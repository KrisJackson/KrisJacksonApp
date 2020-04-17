//
//  JobData.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/17/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class Employer {
    internal struct Data {
        let name: String!
        let web: String!
        let phone: NSNumber!
        let email: String!
        let address: String!
    }
    
    static let Dell: Data = Employer.Data(
        name: "Dell Technologies",
        web: "https://www.delltechnologies.com",
        phone: 869313355,
        email: "delltechnologies1@gmail.com",
        address: "1 Dell Way, Round Rock, Texas, U.S."
        )
    
}
