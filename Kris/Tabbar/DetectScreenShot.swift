//
//  DetectScreenShot.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

extension TabBarViewController {
    
    func screenShot() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil, queue: OperationQueue.main
        ) { notification in
            // Record screenshot taken
            Firestore.firestore().collection("screenshots").document().setData([
                "date": self.getTodayString(),
                "deviceID": UIDevice.current.identifierForVendor!.uuidString,
                "deviceName": UIDevice.current.name,
            ], merge: true)
        }
    }
    
    
    private func getTodayString() -> String {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second

        let today_string = String(month!) + "/" + String(day!) + "/" + String(year!) + " | " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

        return today_string
    }
    
}
