//
//  GoogleAds.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension TabBarViewController: GADBannerViewDelegate {
    
    /// Creates a view above TabBar that contains Google Ad banner
    func configureAd() {
        let testID = "ca-app-pub-3940256099942544/2934735716"
        let productionID = "ca-app-pub-7654666255076412/8220573825"
        
        // Banner view
        let bannerView: GADBannerView = {
            let ad = GADBannerView(adSize: kGADAdSizeBanner)
            ad.load(GADRequest())
            ad.delegate = self
            ad.adUnitID = productionID
            ad.rootViewController = self
            ad.backgroundColor = .clear
            ad.translatesAutoresizingMaskIntoConstraints = false
            
            // Tabbar shadow
            ad.layer.masksToBounds = false
            ad.clipsToBounds = false
            ad.layer.shadowRadius = 1
            ad.layer.shadowOpacity = 1
            ad.layer.shadowOffset = CGSize(width: 0, height: -1)
            ad.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
            return ad
        }()
        
        // add banner about TabBar
        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        bannerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    /**
     Delegate Functions
     -
     */
    
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Animated enterance of ad
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

