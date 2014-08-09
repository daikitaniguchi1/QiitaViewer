class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.configure_navigation_bar

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(EntriesController.new)
    @window.makeKeyAndVisible

    true
  end

  def configure_navigation_bar
    UINavigationBar.appearance.barTintColor = UIColor.colorWithRed(0.249, green:0.833, blue:0.047, alpha:0.7)
    UINavigationBar.appearance.titleTextAttributes = {
        NSForegroundColorAttributeName => UIColor.whiteColor,
        NSFontAttributeName            => UIFont.boldSystemFontOfSize(18)
    }
  end

end
