//
//  AppDelegate.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/15.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit
let appkey = "5715ed5c67e58edd150011b5"
let shareAppjey = "2896135387"
let shareAppSecret = "3afdd132da4cb1e71ac92a8ce1e1690c"
let shareUri = "https://www.baidu.com"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        self.window?.frame = UIScreen.mainScreen().bounds
        self.window?.makeKeyAndVisible()
//        if isNewVersion()
//        {
//            
//              self.window?.rootViewController = MYNewFeatureViewController()
//        }
//        else
//        {
               self.window?.rootViewController = ViewController()
//        }
          return true
    }

    func isNewVersion() -> Bool {
        
        let currentVersionObject = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        let currentVersion = currentVersionObject as! String
        if let lastString = NSUserDefaults.standardUserDefaults().valueForKey("CFBundleShortVersionString")
        {
            let lastVersion = lastString as! String
            if(currentVersion == lastVersion)
            {
            return false
            }
        }
        NSUserDefaults.standardUserDefaults().setValue(currentVersion, forKey: "CFBundleShortVersionString")
        NSUserDefaults.standardUserDefaults().synchronize()
        return true
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        print(url)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

