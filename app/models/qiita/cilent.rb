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

    def self.fetch_tagged_items(tag_name, &block)
      url = BASE_URL + "/tags/#{tag_name}/items"
      BW::HTTP.get(url) do |response|
        items = []
        message = nil
        begin
          if response.ok?
            json = BW::JSON.parse(response.body.to_s)
            # 1件ずつQiita::Itemクラスのインスタンスにして格納
            items = json.map {|data| Qiita::Item.new(data)}
          else
            if response.body.nil?
              message = response.error_message
            else
              json = BW::JSON.parse(response.body.to_s)
              message = json['error']
            end
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

end