module Imgur
  class Base
    def self.api_get(url)
      tries ||= 2
      refresh_token if token_expired?
      headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
      response = Unirest.get(url, headers: headers)
      raise ImgurError if response.body["status"] >= 400
      response
    rescue
      puts response.body
      error = response.body["data"]["error"]
      refresh_token && (tries -= 1).zero? ? (raise ImgurError.new(error)) : retry
    end

    def self.api_post(url, params)
      tries ||= 2
      refresh_token if token_expired?
      headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
      response = Unirest.post(url, headers: headers, parameters: params)
      raise ImgurError if response.body["status"] >= 400
      response
    rescue
      puts response.body
      error = response.body["data"]["error"]
      refresh_token && (tries -= 1).zero? ? (raise ImgurError.new(error)) : retry
    end

    def self.api_delete(url)
      tries ||= 2
      refresh_token if token_expired?
      headers = { "Authorization" => "Bearer #{ENV["IMGUR_TOKEN"]}" }
      response = Unirest.delete(url, headers: headers)
      raise ImgurError if response.body["status"] >= 400
      response
    rescue
      puts response.body
      error = response.body["data"]["error"]
      refresh_token && (tries -= 1).zero? ? (raise ImgurError.new(error)) : retry
    end

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

  class Album < Base
    def self.all
      url = "https://api.imgur.com/3/account/#{ENV["IMGUR_USERNAME"]}/albums"
      api_get(url).body["data"]
    end

    def self.get(imgur_id)
      all.select { |a| a["id"] == imgur_id }.first
    end

    def self.find(title)
      all.select { |a| a["title"] == title }.first
    end

    def self.profile
      find("Users") || create(title: "Users")
    end

    def self.create(options = {})
      url = "https://api.imgur.com/3/album"
      params = {
        ids: options[:ids],
        title: options[:title],
        description: options[:description],
        privacy: options[:privacy],
        cover: options[:cover]
      }
      api_post(url, params).body["data"]
    end

    def self.add_images(imgur_id, image_ids)
      url = "https://api.imgur.com/3/album/#{imgur_id}/add"
      params = {
        ids: image_ids,
      }
      api_post(url, params).body["data"]
    end

    def self.delete(imgur_id)
      url = "https://api.imgur.com/3/album/#{imgur_id}"
      api_delete(url)
    end
  end

  class Image < Base
    def self.create(options)
      url = "https://api.imgur.com/3/image"
      params = {
        image: options[:image],
        album: options[:album_id],
        type: options[:type] || "file", # "file" || "base64" || "URL"
        title: options[:title],
        description: options[:description]
      }
      api_post(url, params).body["data"]
    end

    def self.delete(imgur_id)
      url = "https://api.imgur.com/3/image/#{imgur_id}"
      api_delete(url)
    end
  end

  class ImgurError < StandardError
  end
end
