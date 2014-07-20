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
    # p @entry.image
    # url = NSURL.URLWithString(@entry.image)
    # data = NSData.dataWithContentsOfURL(url)
    # image = UIImage.imageWithData(data)
    # @photo = UIImageView.alloc.initWithFrame(CGRectMake(10.0, 10.0, 200.0, 100.0))
    # @photo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
    # @photo.image = image
    # @name_label = UILabel.alloc.init
    # @name_label.textColor = UIColor.colorWithRed(0, green:0, blue:0, alpha:1.000)
    # @name_label.text = @entry.title
    # self.addSubview(@name_label)
    # self.addSubview(@photo)
    # self
  end
end