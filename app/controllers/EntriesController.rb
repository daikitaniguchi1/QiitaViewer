# Qiita::Client, Qiita::Itemを利用するコントローラ
class EntriesController < UITableViewController

  def viewDidLoad
    super

    self.title = 'Hot Entries'  # ナビゲーションバーのタイトルを変更
    @entries = []  # 取得したエントリを格納

    #  EnryというreuseIdentifierに相当するクラスはEntryCellであることを宣言
    self.tableView.registerClass(EntryCell, forCellReuseIdentifier:'Entry')

    Qiita::Client.fetch_tagged_items do |items, error_message|
      if error_message.nil?
        @entries = items
        @entries.flatten!
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

  # ENTRY_CELL_ID = 'Entry'
  # def tableView(tableView, cellForRowAtIndexPath:indexPath)
  #   cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID, forIndexPath:indexPath)
  #
  #   entry = @entries[indexPath.row]
  #   cell.entry = entry
  #   cell.setNeedsDisplay # 再描画させる
  #
  #   cell
  # end

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