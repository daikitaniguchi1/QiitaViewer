# Qiita::Client, Qiita::Itemを利用するコントローラ
class EntriesController < UITableViewController

  def viewDidLoad
    super

    @tag = 'RubyMotion'
    self.title = @tag  # ナビゲーションバーのタイトルを変更
    @entries = []  # 取得したエントリを格納
    self.tableView.registerClass(EntryCell, forCellReuseIdentifier:'Entry')

    Qiita::Client.fetch_tagged_items(@tag) do |items, error_message|
      if error_message.nil?
        @entries = items
        self.tableView.reloadData
      else
        p error_message
      end
    end
  end

  # テーブルの行数を返却
  def tableView(tableView, numberOfRowsInSection:section)
    @entries.count
  end

  ENTRY_CELL_ID = 'Entry'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID, forIndexPath:indexPath)

    # if cell.nil?
    #   cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: ENTRY_CELL_ID)
    # end

    entry = @entries[indexPath.row]
    # cell.textLabel.text = entry.title
    # cell.detailTextLabel.text = "#{entry.updated_at} by #{entry.username}"
    cell.entry = entry
    cell.setNeedsDisplay # 再描画させる
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    entry = @entries[indexPath.row]

    # # UIWebViewを貼付けたビューコントローラを作成
    # controller = UIViewController.new
    # webview = UIWebView.new
    # webview.frame = controller.view.frame # webviewの表示サイズを調整
    # controller.view.addSubview(webview)

    controller = EntryController.new
    controller.entry = entry

    # 画面遷移
    navigationController.pushViewController(controller, animated:true)

    # # HTML を読み込む
    # webview.loadHTMLString(entry.body, baseURL:nil)
  end

end