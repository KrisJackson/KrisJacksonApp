//
//  Database.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class Database {
    static func getUser(user completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        Firestore.firestore().collection("user").document("mAqeJCIrQXd1XQ0Kr0C3").getDocument { (snapshot, error) in
            completion(snapshot, error)
        }
    }
    
    static func getUserListener(user completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        Firestore.firestore().collection("user").document("mAqeJCIrQXd1XQ0Kr0C3").addSnapshotListener { (snapshot, error) in
            completion(snapshot, error)
        }
    }
}
