module Qiita

  # Qiita API アクセスクラス
  # 特定のタグがつけられた投稿を取得する。
  # また、ブロックを受け取り、データ取得後に非同期で任意の処理を実行できるようにする。
  #
  # @example
  #  Qiita::Client.fetch_tagged_items('tag') { |items, error_message|
  #    # 任意の処理
  #  }
  class Client
    BASE_URL = 'https://qiita.com/api/v1'
    PER_PAGE = 100
    PAGE = 1
    THRESHOLD = 10

    def self.fetch_tagged_items(&block)
      url = BASE_URL + "/items.json?page=#{PAGE}&per_page=#{PER_PAGE}"
      # url = BASE_URL + "/tags/#{tag_name}/items"
      p "in!"
      BW::HTTP.get(url) do |response|
        items = []
        message = nil
        begin
          if response.ok?
            items = get_items(response)
          else
            message = get_error_message(response)
          end
        rescue => e
          p e
          items = []
          message = 'Error'
        end
        block.call(items, message)
      end
    end

    private

    def self.get_items(response)
      p "responsed!"
      json = BW::JSON.parse(response.body.to_s)
      # 1件ずつQiita::Itemクラスのインスタンスにして格納
      # per_page=100の場合は、だいたい直近20時間の間に何ストックされたか。
      items = json.map.with_index(1) {|data, i|
        next if data['stock_count'].to_i < THRESHOLD
        p "========================"
        p "index: #{i}"
        p "title: #{data['title']}"
        p "stock: #{data['stock_count']}"
        p "url: #{data['url']}"
        p "========================"
        Qiita::Item.new(data)
      }.compact!
    end

    def self.get_error_message(response)
      if response.body.nil?
        response.error_message
      else
        json = BW::JSON.parse(response.body.to_s)
        json['error']
      end
    end

  end
end