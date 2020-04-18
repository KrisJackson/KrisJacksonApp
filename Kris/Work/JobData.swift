//
//  JobData.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/17/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class Company {
    internal struct Data {
        let name: String!
        let web: String!
        let industry: String!
        let hq: String!
        let address: String!
    }
    
    static let Dell: Data = Data(
        name: "Dell Technologies",
        web: "https://www.delltechnologies.com",
        industry: "Information Technology & Services",
        hq: "Round Rock, Texas",
        address: "1 Dell Way, Round Rock, TX"
        )
    
    static let Mozilla: Data = Data(
        name: "Mozilla Foundation",
        web: "https://www.mozilla.org",
        industry: "Computer Software",
        hq: "Mountain View, California",
        address: "331 E Evelyn Ave, Mountain View, CA"
        )
    
    static let Netswitch: Data = Data(
        name: "Netswitch LLC",
        web: "https://www.netswitchllc.com",
        industry: "Internet",
        hq: "Memphis, Tennessee",
        address: "2000 North Parkway, Memphis, TN"
        )
    
    static let Moment: Data = Data(
        name: "Moment AI",
        web: "https://www.everymoment.ai/",
        industry: "Computer Software & Automotive",
        hq: "District of Columbia",
        address: "Georgia Ave Petworth Station, District of Freedom, Washington, DC"
    )
    
    static let UTHSC: Data = Data(
        name: "University of Tennessee Health Science Center",
        web: "https://www.uthsc.edu/",
        industry: "Higher Education",
        hq: "Memphis, Tennessee ",
        address: "920 Madison Ave., Suite 810, Memphis, TN"
    )
    
}
