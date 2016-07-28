//
//  AppDelegate.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application,didFinishLaunchingWithOptions: launchOptions)
        Fabric.with([Crashlytics.self])
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

