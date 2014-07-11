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

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)

    if cell.nil?
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: ENTRY_CELL_ID)
    end

    entry = @entries[indexPath.row]
    cell.textLabel.text = entry.title
    cell.detailTextLabel.text = "#{entry.updated_at} by #{entry.username}"
    cell
  end

end