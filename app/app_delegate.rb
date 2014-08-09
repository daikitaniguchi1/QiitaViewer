class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.configure_status_bar
    self.configure_navigation_bar

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(EntriesController.new)
    @window.makeKeyAndVisible

    true
  end

  def configure_status_bar
    # if UIDevice.currentDevice.ios7?
      UIApplication.sharedApplication.setStatusBarStyle(UIStatusBarStyleLightContent)
    # else
    #   UIApplication.sharedApplication.setStatusBarStyle(UIStatusBarStyleBlackOpaque)
    # end
  end

  def configure_navigation_bar
      UINavigationBar.appearance.barTintColor = UIColor.colorWithRed(0.249, green:0.833, blue:0.047, alpha:0.7)
      UINavigationBar.appearance.titleTextAttributes = {
          NSForegroundColorAttributeName => UIColor.whiteColor,
          NSFontAttributeName            => UIFont.boldSystemFontOfSize(21)
      }
      UINavigationBar.appearance.tintColor = UIColor.whiteColor
  end

  def configure_bar_button_item
    unless UIDevice.currentDevice.ios7?
      background_image = UIImage.imageNamed("UIBarButtonItemBarBackGround.png")
      UIBarButtonItem.appearanceWhenContainedIn(UINavigationBar, nil).setBackgroundImage(background_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
      UIBarButtonItem.appearanceWhenContainedIn(UINavigationBar, nil).setBackButtonBackgroundImage(background_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
    end
  end


end
