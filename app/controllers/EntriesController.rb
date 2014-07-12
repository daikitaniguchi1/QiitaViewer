# Qiita::Client, Qiita::Itemを利用するコントローラ
class EntriesController < UITableViewController

  def viewDidLoad
    super

    @tag = 'RubyMotion'
    self.title = @tag
    @entries = []
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

    # UIWebViewを貼付けたビューコントローラを作成
    controller = UIViewController.new
    webview = UIWebView.new
    webview.frame = controller.view.frame # webviewの表示サイズを調整
    controller.view.addSubview(webview)

    # 画面遷移
    navigationController.pushViewController(controller, animated:true)

    # HTML を読み込む
    webview.loadHTMLString(entry.body, baseURL:nil)
  end

end