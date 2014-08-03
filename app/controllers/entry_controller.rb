class EntryController < UIViewController
  attr_accessor :entry

  def viewDidLoad
    super

    webview = UIWebView.new.tap do |wv|
      wv.frame = view.frame  # webviewの表示サイズを調整
      wv.scalesPageToFit = true  # ピンチイン・アウトを可能にする
      view.addSubview(wv)
    end
    url = NSURL.URLWithString(@entry.url)
    request = NSURLRequest.requestWithURL(url)
    webview.loadRequest request
  end
end