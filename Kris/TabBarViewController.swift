//
//  TabBarViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import CoreTelephony

var numberOfNewMessages = Int()

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var currentVC = 0
    var headerHeight: CGFloat = 0
    let logoImage = UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate)
    let inboxImage = UIImage(named: "Inbox")?.withRenderingMode(.alwaysTemplate)
    
    var inboxBottom: NSLayoutConstraint!
    
    var hasInbox = false
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
        return view
    }()
    
    lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = logoImage
        imageView.tintColor = ColorTheme.white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var inbox: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(inboxImage, for: .normal)
        button.layer.cornerRadius = 30
        button.tintColor = ColorTheme.white
        button.backgroundColor = ColorTheme.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToInbox), for: .touchUpInside)
        button.addTarget(self, action: #selector(hideInbox), for: .touchDragExit)
        
        // Tabbar shadow
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureTabBarAppearance()
        configureHeaderAndLogo()
        configureInboxButton()
        screenShot()
        
        // Present Notifications
//        getNewMessage()
//        getNewBlog()
    }
    
    /**
     
     configureTabBarAppearance - configures the design of tabbar ui
     
     */
    private func configureTabBarAppearance() {
        let appearance = tabBar.standardAppearance
        // Remove top line
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        // Backgroud color and item position
        appearance.backgroundColor = ColorTheme.tabBarBackgroundColor
        appearance.stackedItemPositioning = .centered
        
        // Unselected color
        appearance.stackedLayoutAppearance.normal.iconColor = ColorTheme.unselectedTabBarIcon
        
        // Selected color
        appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = ColorTheme.blue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorTheme.blue]
        
        // Set appearance
        tabBar.standardAppearance = appearance
        
        // Tabbar icon text
        tabBar.items?[0].title = nil
        tabBar.items?[1].title = nil
        tabBar.items?[2].title = nil
        tabBar.items?[3].title = nil
        tabBar.items?[4].title = nil
        
        // Tabbar shadow
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
    }
    
    /**
     
     configureHeaderAndLogo - configures the design of headerview and logo ui
     
     */
    private func configureHeaderAndLogo() {
        // Configs headerview
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // Adds logo to header view
        headerView.addSubview(logo)
        logo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logo.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        logo.topAnchor.constraint(equalTo: headerView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        headerHeight = (8 * 2) + 30
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showInbox))
        headerView.addGestureRecognizer(tap)
    }
    
    private func configureInboxButton() {
        let isCorrectID = UIDevice.current.identifierForVendor!.uuidString == "480CAAB3-68AA-4488-9FB2-7337EE92C912"
        let isCorrectDeviceName = UIDevice.current.name == "KJ::pHQy7umXInI3qoPS"
        if (isCorrectID && isCorrectDeviceName) {
            view.addSubview(inbox)
            inbox.heightAnchor.constraint(equalToConstant: 60).isActive = true
            inbox.widthAnchor.constraint(equalTo: inbox.heightAnchor).isActive = true
            inbox.rightAnchor.constraint(equalTo: tabBar.rightAnchor, constant: -16).isActive = true
            inboxBottom = inbox.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -16)
            inboxBottom.isActive = true
            hasInbox = true
        }
    }
    
    @objc func goToInbox() {
        self.performSegue(withIdentifier: "goToInbox", sender: self)
    }
    
    @objc private func hideInbox() {
        if (hasInbox) {
            UIView.animate(withDuration: 0.5, animations: {
                self.inbox.alpha = 0
                self.inbox.isEnabled = false
            }, completion: nil)
        }
    }
    
    @objc private func showInbox() {
        if (hasInbox) {
            UIView.animate(withDuration: 0.5, animations: {
                self.inbox.alpha = 1
                self.inbox.isEnabled = true
            }, completion: nil)
        }
    }
}

