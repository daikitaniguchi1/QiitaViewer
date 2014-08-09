# Qiita::Client, Qiita::Itemを利用するコントローラ
class EntriesController < UITableViewController

  def viewDidLoad
    super

    self.title = 'Qiita ホットエントリー'  # ナビゲーションバーのタイトル
    @entries = []  # 取得したエントリを格納

    #  EnryというreuseIdentifierに相当するクラスはEntryCellであることを宣言
    self.tableView.registerClass(EntryCell, forCellReuseIdentifier:'Entry')

    @refreshControl = UIRefreshControl.alloc.init
    @refreshControl.addTarget(self,
                              action:"onRefresh",
                              forControlEvents:UIControlEventValueChanged)
    self.refreshControl = @refreshControl

    Qiita::Client.fetch_tagged_items do |items, error_message|
      if error_message.nil?
        @entries = items.flatten!
        self.tableView.reloadData
      else
        p error_message
      end
    end
  end

  def onRefresh
    self.refreshControl.beginRefreshing
    Qiita::Client.fetch_tagged_items do |items, error_message|
      if error_message.nil?
        @entries = items.flatten!
        self.refreshControl.endRefreshing
        self.tableView.reloadData
      else
        p error_message
      end
    end
  end

  # テーブルの行数（セル数）を決定
  def tableView(tableView, numberOfRowsInSection:section)
    @entries.count
  end

  # 各セルの中身を決定
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    post = @entries[indexPath.row]  # 今何行目？
    EntryCell.cellForPost(post, inTableView:tableView)
  end

  # 各セルをタップした時の挙動を決定
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    entry = @entries[indexPath.row]

    controller = EntryController.new
    controller.entry = entry

    # webviewに画面遷移
    navigationController.pushViewController(controller, animated:true)
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    EntryCell.heightForPost(@entries[indexPath.row], tableView.frame.size.width)
  end

  def reloadRowForPost(post)
    row = @entries.index(post)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)], withRowAnimation:false)
    end
  end

end