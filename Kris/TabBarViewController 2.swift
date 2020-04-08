//
//  TabBarViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import CoreTelephony
//import CWNotificationBanner

var numberOfNewMessages = Int()

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var currentVC = 0
    
    var bannerView: GADBannerView!
    var headerHeight: CGFloat = 0
    let logoImage = UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate)
    
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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        isBlocked()
        configureTabBarAppearance()
        configureHeaderAndLogo()
//        configureAd(ad: bannerView)
        screenShot()
        getNewMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isBlocked()
    }
    
    func isBlocked() {
        Firestore.firestore().collection("devices").document(UIDevice.current.identifierForVendor!.uuidString).getDocument { (snapshot, error) in
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    if let isBlocked = snapshot.data()!["blocked"] as? Bool {
                        
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
    
    private func screenShot() {
        
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in

            Firestore.firestore().collection("screenshots").document().setData([
                "date": self.getTodayString(),
                "deviceID": UIDevice.current.identifierForVendor!.uuidString,
                "deviceName": UIDevice.current.name,
            ], merge: true)

        }
    }
    
    func getTodayString() -> String {

            let date = Date()
            let calender = Calendar.current
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

            let year = components.year
            let month = components.month
            let day = components.day
            let hour = components.hour
            let minute = components.minute
            let second = components.second

            let today_string = String(month!) + "/" + String(day!) + "/" + String(year!) + " | " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

            return today_string

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
    
    private func getNewMessage() {
        var isInitial = true
        Firestore.firestore().collection("test")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    snapshot.documentChanges.forEach { (diff) in
                        if ((diff.type == .added) && (!isInitial)) {
                            self.presentNotification()
                        }
                    }
                    isInitial = false
                }
        }
    }

    func presentNotification() {
        var notificationTopAnchor: NSLayoutConstraint!
        let notificationView: UIView = {
            let view = UIView()
            view.frame.size.width = view.frame.width - 24
            view.layer.cornerRadius = 8
            view.backgroundColor = ColorTheme.aboutMeMoreBackground
            view.translatesAutoresizingMaskIntoConstraints = false

            view.layer.shadowRadius = 2
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor

            return view
        }()

        let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 2
            label.textColor = ColorTheme.black
            label.font = .systemFont(ofSize: 17, weight: .medium)
            label.text = "🎉 Kris sent you a new message! 🎉"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()


        view.addSubview(notificationView)
        view.bringSubviewToFront(headerView)
        notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notificationTopAnchor = notificationView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1000)
        notificationTopAnchor.isActive = true

        notificationView.addSubview(label)
        label.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 12).isActive = true
        label.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -12).isActive = true
        label.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -15).isActive = true
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            notificationTopAnchor.constant = 12
        }) { (finished) in
            if finished {
                
                Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (_) in
                     UIView.animate(withDuration: 0.3) {
                        notificationTopAnchor.constant = -100
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    
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
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // slide views to the side
        if let fromView = tabBarController.selectedViewController?.view,
            let toView = viewController.view, fromView != toView,
            let controllerIndex = self.viewControllers?.firstIndex(of: viewController) {

            let viewSize = fromView.frame
            let scrollRight = controllerIndex > tabBarController.selectedIndex

            // Avoid UI issues when switching tabs fast
            if fromView.superview?.subviews.contains(toView) == true { return false }

            fromView.superview?.addSubview(toView)

            let screenWidth = UIScreen.main.bounds.size.width
            toView.frame = CGRect(x: (scrollRight ? screenWidth : -screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)

            UIView.animate(withDuration: 0.15, delay: TimeInterval(0.0), options: [.curveEaseOut, .preferredFramesPerSecond60], animations: {
                fromView.frame = CGRect(x: (scrollRight ? -screenWidth : screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
                toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
            }, completion: { finished in
                if finished {
                    fromView.removeFromSuperview()
                    tabBarController.selectedIndex = controllerIndex
                }
            })
        }
    
        // dismiss and scroll to top
        guard let viewControllers = viewControllers else { return false }
        if viewController == viewControllers[selectedIndex] {
            if let nav = viewController as? UINavigationController {
                guard let topController = nav.viewControllers.last else { return true }
                if (!topController.isScrolledToTop) {
                    topController.scrollToTop()
                    return false
                }
                nav.popViewController(animated: true)
                return false
            }
        }

        return true
    }
    
}

extension UIViewController {
    func scrollToTop() {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }
            switch view {
            case let scrollView as UIScrollView:
                if (scrollView.scrollsToTop == true) {
                    scrollView.setContentOffset(.zero, animated: true)
                    return
                }
            default:
                break
            }

            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }
        scrollToTop(view: view)
    }

    var isScrolledToTop: Bool {
        for subView in view.subviews {
            if let scrollView = subView as? UIScrollView {
                return (scrollView.contentOffset.y == 0)
            }
        }
        return true
    }
}

extension TabBarViewController: GADBannerViewDelegate { // Any Banner Ad related functions

    
    func configureAd(ad: GADBannerView) {
        let testID = "ca-app-pub-3940256099942544/2934735716"
        let productionID = "ca-app-pub-7654666255076412/8220573825"
        
        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
//        bannerView.layer.cornerRadius = 0
        bannerView.adUnitID = testID
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        // Tabbar shadow
        bannerView.layer.masksToBounds = false
        bannerView.clipsToBounds = false
        bannerView.layer.shadowRadius = 1
        bannerView.layer.shadowOpacity = 1
        bannerView.layer.shadowOffset = CGSize(width: 0, height: -1)
        bannerView.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }


    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }

    
}
