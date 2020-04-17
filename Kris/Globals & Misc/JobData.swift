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
    
    
    
}
