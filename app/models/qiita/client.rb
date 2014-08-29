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
    # BASE_URL = 'https://qiita.com/api/v1'
    BASE_URL = 'http://qiita-server.herokuapp.com/api/items'
    PAGE_NUM = 1
    PER_PAGE = 30
    THRESHOLD = 30

    def self.fetch_tagged_items(&block)
      items = []
      message = nil
      PAGE_NUM.times do |i|
        page = (i+1).to_s
        BW::HTTP.get(BASE_URL) do |response|
          begin
            if response.ok?
              items << get_items(response)
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
    end

    private

    def self.get_items(response)
      # 1件ずつQiita::Itemクラスのインスタンスにして格納
      # per_page=100につき、だいたい直近20時間の間に何ストックされたか。
      BW::JSON.parse(response.body.to_s).map.with_index(1) {|item, i|
        next if item['data']['stock_count'].to_i < THRESHOLD
        Qiita::Item.new(item['data'])
      }
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