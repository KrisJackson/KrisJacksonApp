//
//  AppDelegate.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
import GoogleMobileAds
import DeviceCheck
import SDWebImageLinkPlugin


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyAD9ePBI2HZ1u8ScKgIc786N1b_S9jSmfM")
        GMSPlacesClient.provideAPIKey("AIzaSyAD9ePBI2HZ1u8ScKgIc786N1b_S9jSmfM")
        
        SDImageLoadersManager.shared.addLoader(SDImageLinkLoader.shared)
        SDWebImageManager.defaultImageLoader = SDImageLoadersManager.shared
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        getUser()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print(fcmToken)
    }
}



