class EntryController < UIViewController
  attr_accessor :entry

  def viewDidLoad
    super
    
    webview = UIWebView.new
    webview.frame = view.frame # webviewの表示サイズを調整
    view.addSubview(webview)
    webview.loadHTMLString(@entry.body, baseURL: nil)
  end
end