//
//  RecordDevice.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import CoreTelephony

extension AppDelegate {
    
    internal func getUser() {
        Firestore.firestore().collection("devices")
            .document(UIDevice.current.identifierForVendor!.uuidString).setData([
                "deviceID": UIDevice.current.identifierForVendor!.uuidString,
                "deviceName": UIDevice.current.name,
                "systemName": UIDevice.current.systemName,
                "systemVersion": UIDevice.current.systemVersion,
                "localizedModel": UIDevice.current.localizedModel,
                "model": UIDevice.current.model,
                "device": UIDevice.modelName,
                "regionCode": Locale.current.regionCode ?? "Not Applicable",
                "timezone": TimeZone.current.abbreviation() ?? "Not Applicable",
                "lastLogIn": getTodayString()
            ], merge: true)
    }

    private func getTodayString() -> String {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents(
            [.year,.month,.day,.hour,.minute,.second],
            from: date
        )
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
