class EntryCell < UITableViewCell
  attr_accessor :entry

  def initWithStyle(style, reuseIdentifier:reuseIdentifier)
    # UITableViewCellStyleSubtitleスタイルを使う
    super(UITableViewCellStyleSubtitle, reuseIdentifier:reuseIdentifier)
  end

  def drawRect(rect)
    super
    self.textLabel.text = @entry.title
    self.detailTextLabel.text = "#{@entry.stocks} stocks! by #{@entry.username}"
  end
end