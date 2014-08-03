module Qiita

  # Qiita API から取得したデータを保持
  class Item
    attr_accessor :title, :username, :updated_at, :body, :stocks, :image, :url

    def initialize(data)
      @title = data['title']
      @username = data['user']['url_name']
      @updated_at = data['updated_at_in_words']
      @body = data['body']
      @stocks = data['stock_count']
      @url = data['url']
      @image = data['user']['profile_image_url']
    end
  end
end