//
//  BlockedViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class BlockedViewController: UIViewController {
    
}

class Blocked {
    private var target: AnyObject!
    
    /// Function prevents a user from entering the app if a user is blocked
    func isBlocked() {
        
        // Vendor ID changes if app is deleted and redownloaded
        let vendorID = UIDevice.current.identifierForVendor!.uuidString
        
        // Checks if device is blocked
        Firestore.firestore().collection("devices")
            .document(vendorID).getDocument { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                DispatchQueue.main.async {
                    // Present controller if user is blocked
                    if let isBlocked = snapshot.data()!["blocked"] as? Bool {
                        if isBlocked { self.presentBlockedController() }
                    }
                }
        }
    }
    
    private func presentBlockedController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Blocked") as! BlockedViewController
        vc.modalPresentationStyle = .fullScreen
        target.present(vc, animated: false, completion: nil)
    }
    
    init(target vc: AnyObject) {
        target = vc
    }
}
