# Qiita::Client, Qiita::Itemを利用するコントローラ
class EntriesController < UITableViewController

  def viewDidLoad
    super

    @tag = 'RubyMotion'
    self.title = @tag
    @entries = []

    Qiita::Client.fetch_tagged_items(@tag) do |items, error_message|
      if error_message.nil?
        @entries = items
        self.tableView.reloadData
      else
        p error_message
      end
    end
  end
end