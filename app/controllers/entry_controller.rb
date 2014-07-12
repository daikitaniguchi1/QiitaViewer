class EntryController < UIViewController
  attr_accessor :entry

  def viewDidLoad
    super
    
    webview = UIWebView.new
    webview.frame = view.frame
    view.addSubview(webview)
    webview.loadHTMLString(@entry.body, baseURL: nil)
  end
end