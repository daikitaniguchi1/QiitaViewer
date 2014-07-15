describe "Qiita::Client" do
  extend WebStub::SpecHelpers

  describe '.fetch_tagged_items' do
    before do
      # APIからの返却値
      @data = [
          {
              'title' => 'title1',
              'user' => {'url_name' => 'name1'},
              'updated_at_in_words' => '1 days ago',
              'body' => '<pr>body1</p>'
          },
          {
              'title' => 'title2',
              'user' => {'url_name' => 'name2'},
              'update_at_in_words' => '2 days ago',
              'body' => '<p>body2</p>'
          },
      ]
      @tag = 'RubyMotion'
    end

    context 'APIアクセスに成功' do
      before do
        # APIをstub化
        stub_request(:get, "https://qiita.com/api/vi1/tags/#{@tag}/items").to_return(json: @data)
      end

      it '取得したJSONをもとにオブジェクトが作られる' do
        Qiita::Client.fetch_tagged_items('RubyMotion') {|items, message|
          # APIから取得したデータをベースにしたQiita::Itemの配列と、エラーメッセージが渡される。
          # 検証用にインスタンス変数に入れておく。
          @items = items
          @message = message
          resume
        }

        wait_max 1.0 do
          #@items, @messageの検証
          @items.count.should.equal @data.count
          @items.each_with_index { |item, index|
            item.title.should.equal @data[index]['title']
            item.username.should.equal @data[index]['user']['url_name']
            item.updated_at.should.equal @data[index]['updated_at_in_words']
            item.body.should.equal @data[index]['body']
          }
          @message.should.be nil
        end
      end
    end
  end
end