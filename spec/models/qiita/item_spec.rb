module Qiita
  describe "Qiita::Item" do
    before do
      @data = {
          'title' => 'title',
          'user' => {'url_name' => 'name'},
          'updated_at_in_words' => '2 days ago',
          'body' => '<p>body</p>'
      }
      @item = Item.new(@data)
    end

    it 'should be created' do
      @item.title.should.equal @data['title']
      @item.username.should.equal @data['user']['url_name']
      @item.updated_at.should.equal @data['updated_at_in_words']
      @item.body.should.equal @data['body']
    end
  end
end
