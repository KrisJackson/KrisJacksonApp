//
//  PresentNotification.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

extension TabBarViewController {
    
    func getNewMessage() {
        var isInitial = true
        Firestore.firestore().collection("messages")
            .whereField("fromOwner", isEqualTo: true)
            .whereField("userID", isEqualTo: UIDevice.current.identifierForVendor!.uuidString)
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    snapshot.documentChanges.forEach { (diff) in
                        if ((diff.type == .added) && (!isInitial)) {
                            
                            let pStyle = NSMutableParagraphStyle()
                            pStyle.lineSpacing = 2
                            pStyle.alignment = .center
                            
                            let header = NSMutableAttributedString(string: "Kris ", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                            ])
                    
                            let body = NSMutableAttributedString(string: "just sent you a ", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                NSAttributedString.Key.paragraphStyle: pStyle
                            ])
                            
                            let type = NSMutableAttributedString(string: "new message", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
                            ])
                            let pun = NSMutableAttributedString(string: "! 🎉", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                            ])
                            
                            header.append(body)
                            header.append(type)
                            header.append(pun)
                            self.presentNotification(string: header)
                        }
                    }
                    isInitial = false
                }
        }
    }
    
    func getNewBlog() {
        var isInitial = true
        Firestore.firestore().collection("blog")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    snapshot.documentChanges.forEach { (diff) in
                        if ((diff.type == .added) && (!isInitial)) {
                            
                            let pStyle = NSMutableParagraphStyle()
                            pStyle.lineSpacing = 2
                            pStyle.alignment = .center
                            
                            let header = NSMutableAttributedString(string: "Kris ", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                            ])
                    
                            let body = NSMutableAttributedString(string: "just added a ", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                NSAttributedString.Key.paragraphStyle: pStyle
                            ])
                            
                            let type = NSMutableAttributedString(string: "new blog post", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                                NSAttributedString.Key.foregroundColor: ColorTheme.blue,
                            ])
                            let pun = NSMutableAttributedString(string: "! 📝", attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                NSAttributedString.Key.paragraphStyle: pStyle,
                            ])
                            
                            header.append(body)
                            header.append(type)
                            header.append(pun)
                            self.presentNotification(string: header)
                        }
                    }
                    isInitial = false
                }
        }
    }

    func presentNotification(string: NSMutableAttributedString) {
        var notificationTopAnchor: NSLayoutConstraint!
        let notificationView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 8
            view.backgroundColor = ColorTheme.white
            view.translatesAutoresizingMaskIntoConstraints = false

            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)

            return view
        }()

        let label: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.attributedText = string
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        view.addSubview(notificationView)
        view.bringSubviewToFront(headerView)
        notificationView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
        notificationView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        notificationTopAnchor = notificationView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1000)
        notificationTopAnchor.isActive = true

        notificationView.addSubview(label)
        label.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -15).isActive = true
    
        animateEntryExit(notificationView: notificationView, notificationTopAnchor: notificationTopAnchor)
    
    }
    
    private func animateEntryExit(notificationView: UIView, notificationTopAnchor: NSLayoutConstraint) {
        Vibration.success.vibrate()
        UIView.animate(withDuration: 0.3, animations: {
            notificationTopAnchor.constant = 8
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                     UIView.animate(withDuration: 0.3, animations: {
                        notificationTopAnchor.constant = -100
                        self.view.layoutIfNeeded()
                     }) { (_) in
                        
                        notificationView.removeFromSuperview()
                        
                    }
                }
            }
        }
    }
    
}
