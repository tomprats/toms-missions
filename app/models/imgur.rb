class Imgur
  def self.albums
    url = "https://api.imgur.com/3/account/#{ENV["IMGUR_USERNAME"]}/albums"
    get(url).body["data"]
  end

  def self.find_album(title)
    albums.select { |a| a["title"] == title }.first
  end

  def self.profile_album
    Imgur.find_album("Missionaries")
  end

  def self.upload_profile(image, title)
    id = Imgur.profile_album["id"]
    upload_image(
      image: image,
      album_id: id,
      title: title
    )
  end

  def self.upload_image(options)
    url = "https://api.imgur.com/3/image"
    params = {
      image: options[:image],
      album: options[:album_id],
      type: "file" || "base64" || "URL",
      title: options[:title],
      description: options[:description]
    }
    post(url, params).body["data"]
  end

  def self.delete_image(link)
    url = "https://api.imgur.com/3/image/#{parse_id(link)}"
    delete(url)
  end

  def self.create_album(options = {})
    url = "https://api.imgur.com/3/album"
    params = {
      ids: options[:ids],
      title: options[:title],
      description: options[:description],
      privacy: options[:privacy],
      cover: options[:cover]
    }
    post(url, params).body["data"]
  end

  # HTTP Methods
  def self.get(url)
    refresh_token if token_expired?
    headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
    Unirest.get(url, headers: headers)
  rescue
    raise ImgurError
  end

  def self.post(url, params)
    refresh_token if token_expired?
    headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
    Unirest.post(url, headers: headers, parameters: params)
  rescue
    raise ImgurError
  end

  def self.delete(url)
    refresh_token if token_expired?
    headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
    Unirest.delete(url, headers: headers)
  rescue
    raise ImgurError
  end

  private
  def self.refresh_token
    url = "https://api.imgur.com/oauth2/token"
    params = {
      refresh_token: ENV["IMGUR_REFRESH"],
      client_id: ENV["IMGUR_ID"],
      client_secret: ENV["IMGUR_SECRET"],
      grant_type: :refresh_token
    }
    headers = { "Authorization" => "Client-ID #{ENV["IMGUR_ID"]}" }
    response = Unirest.post(url, headers: headers, parameters: params)

    ENV["IMGUR_TIMEOUT"] = calculate_timeout(response.body["expires_in"])
    ENV["IMGUR_TOKEN"] = response.body["access_token"]

    response
  rescue
    raise ImgurError
  end

  def self.token_expired?
    (ENV["IMGUR_TIMEOUT"].try(:to_i) || 0) < DateTime.now.to_i
  end

  def self.calculate_timeout(expires_in)
    (DateTime.now.to_i + expires_in).to_s
  end

  def self.parse_id(link)
    File.basename(link, ".*")
  end
end

class ImgurError < StandardError
end
