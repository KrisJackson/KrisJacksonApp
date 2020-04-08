//
//  BlockUser.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

extension TabBarViewController {
    
    /// Function prevents a user from entering the app if a user is blocked
    func isBlocked() {
        // Vendor ID changes if app is deleted and redownloaded
        let vendorID = UIDevice.current.identifierForVendor!.uuidString
        
        // Checks if device is blocked
        Firestore.firestore().collection("devices")
            .document(vendorID).getDocument { (snapshot, error) in
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        if let isBlocked = snapshot.data()!["blocked"] as? Bool {
                            // Present controller if user is blocked
                            if isBlocked {
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyBoard.instantiateViewController(withIdentifier: "blocked") as! Blocked
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: false, completion: nil)
                            }
                        }
                    }
                }
        }
    }
    
}
