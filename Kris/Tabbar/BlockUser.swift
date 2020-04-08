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
    func isBlocked() {
        Firestore.firestore().collection("devices").document(UIDevice.current.identifierForVendor!.uuidString).getDocument { (snapshot, error) in
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
