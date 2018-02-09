//
//  AppDelegate.swift
//  Homepwner1
//
//  Created by Steve Duran on 9/26/17.
//  Copyright © 2017 Steve Duran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let itemStore = ItemStore() //create store

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create an ImageStore
        let imageStore = ImageStore()
        
        
        //this dictates who the root view is. We are using navigationController
        let navController = window!.rootViewController as! UINavigationController
        let itemController = navController.topViewController as! ItemsViewController
        itemController.itemStore = itemStore
        itemController.imageStore = imageStore
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //check to see if changes were saved to system while
        // home button is prerssed
        let success = itemStore.saveChanges()
        if (success) {
            print("Saved all of the Items") } else {
            print("Could not save any of the Items") }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
