# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'QiitaViewer'
  app.provisioning_profile = 'iOS_Team_Provisioning_Profile.mobileprovision'
  app.codesign_certificate = 'iPhone Developer: Daiki Taniguchi'
  app.deployment_target = "7.0"

  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
end
