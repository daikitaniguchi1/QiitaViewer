class EntryCell < UITableViewCell
  attr_accessor :entry
  ENTRY_CELL_ID = 'Entry'
  MessageFontSize = 14

  def self.cellForPost(post, inTableView:tableView)
    # p tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)
    # p EntryCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
    # cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID) || EntryCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    cell = EntryCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
    cell.fillWithPost(post, inTableView:tableView)
    cell
  end

  def initWithStyle(style, reuseIdentifier:cellid)
    if super
      self.textLabel.numberOfLines = 0
      self.textLabel.font = UIFont.systemFontOfSize(MessageFontSize)
    end
    self
  end

  def fillWithPost(post, inTableView:tableView)
    self.textLabel.text = "【#{post.stocks} stocks!】#{post.title}"
    # self.detailTextLabel.text = "#{post.stocks} stocks! by #{post.username}"

    unless post.profile_image
      self.imageView.image = UIImage.imageNamed('reddit')
      Dispatch::Queue.concurrent.async do
        profile_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(post.profile_image_url))
        if profile_image_data
          post.profile_image = UIImage.alloc.initWithData(profile_image_data)
          Dispatch::Queue.main.sync do
            self.imageView.image = post.profile_image
            tableView.delegate.reloadRowForPost(post)
          end
        end
      end
    else
      self.imageView.image = post.profile_image
    end
  end

  def self.heightForPost(post, width)
    constrain = CGSize.new(width - 57, 1000)
    size = post.title.sizeWithFont(UIFont.systemFontOfSize(MessageFontSize), constrainedToSize:constrain)
    [57, size.height + 8].max
  end

  def layoutSubviews
    super
    self.imageView.frame = CGRectMake(2, 2, 49, 49)
    label_size = self.frame.size
    self.textLabel.frame = CGRectMake(57, 0, label_size.width - 59, label_size.height)
  end

  #
  # def initWithStyle(style, reuseIdentifier:reuseIdentifier)
  #   # UITableViewCellStyleSubtitleスタイルを使う
  #   super(UITableViewCellStyleSubtitle, reuseIdentifier:reuseIdentifier)
  # end
  #
  # def drawRect(rect)
  #   super
  #   self.textLabel.text = @entry.title
  #   self.detailTextLabel.text = "#{@entry.stocks} stocks! by #{@entry.username}"
  #   # p @entry.image
  #   # url = NSURL.URLWithString(@entry.image)
  #   # data = NSData.dataWithContentsOfURL(url)
  #   # image = UIImage.imageWithData(data)
  #   # @photo = UIImageView.alloc.initWithFrame(CGRectMake(10.0, 10.0, 200.0, 100.0))
  #   # @photo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight
  #   # @photo.image = image
  #   # @name_label = UILabel.alloc.init
  #   # @name_label.textColor = UIColor.colorWithRed(0, green:0, blue:0, alpha:1.000)
  #   # @name_label.text = @entry.title
  #   # self.addSubview(@name_label)
  #   # self.addSubview(@photo)
  #   # self
  # end
end