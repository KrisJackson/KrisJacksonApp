//
//  Timestamp.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class Timestamp {
    static func unixToDateTime(unix: NSNumber?, timeStyle:  DateFormatter.Style, dateStyle:  DateFormatter.Style) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: unix!)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = dateStyle
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    static func unixToShortDate(unix: NSNumber?) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: unix!)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        if (NSCalendar.current.isDateInToday(date)){
            
           dateFormatter.timeStyle = DateFormatter.Style.short
           dateFormatter.dateStyle = DateFormatter.Style.none
           let time = dateFormatter.string(from: date)
           return time
            
        } else if (NSCalendar.current.isDateInYesterday(date)){
            
            return "Yesterday"
            
        } else {
            
           dateFormatter.timeStyle = DateFormatter.Style.none
           dateFormatter.dateStyle = DateFormatter.Style.medium
           let time = dateFormatter.string(from: date)
           return time
            
        }

    }
}
