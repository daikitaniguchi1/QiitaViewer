class EntryController < UIViewController
  attr_accessor :entry

  def viewDidLoad
    super
    
    # webview = UIWebView.new
    # webview.frame = view.frame # webviewの表示サイズを調整
    # view.addSubview(webview)
    # webview.loadHTMLString(@entry.body, baseURL: nil)

    webview = UIWebView.new.tap do |v|
      v.frame = self.view.bounds
      v.scalesPageToFit = true
      # v.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(self.item[:link])))
      v.delegate = self
      view.addSubview(v)
    end
    webview.loadHTMLString(@entry.body, baseURL: nil)

  end
end