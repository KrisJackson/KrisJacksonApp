//
//  AboutMeViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import SafariServices
import CoreLocation
import MapKit
import GoogleMaps

class AboutMeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    let user: UserData = {
        let user = UserData()
        user.first = "Kristopher"
        user.last = "Jackson"
        user.summary = "Computer Science major seeking a position as a full-time iOS or Software Developer starting in the Fall of 2021."
        user.birthday = "July 3, 1998"
        user.phone = 2256105747
        user.email = "kristopherrjackson@gmail.com"
        user.pFirst = "Kris"
        user.linkedin = "https://linkedin.kristopherjackson.com"
        user.portfolio = "https://portfolio.kristopherjackson.com"
        user.instagram = "https://instagram.kristopherjackson.com"
        user.resume = "https://resume.kristopherjackson.com"
        user.website = "https://www.kristopherjackson.com"
        user.stay = "Memphis, Tennessee"
        user.objective = "Computer Science major seeking a full-time position in iOS Development or Software Engineering starting in the Fall of 2021. I have more than three years of professional programming experience, two years working with an outstanding team as co-founder of Netswitch LLC, and I have spent the last two summers working at Dell Technologies as a Machine Learning Intern. I am a leader, and I intend build more leaders throughout my lifelong journey in the tech industry."
        return user
    }()
    
    let highschool: Education = {
        let school = Education()
        school.name = "Episcopal School of BR"
        school.phone = 2257533180
        school.state = "Louisiana"
        school.state_abr = "LA"
        school.type = "High School"
        school.website = "https://www.episcopalbr.org"
        school.location = GeoPoint(latitude: 30.422687, longitude: -91.032938)
        school.graduation = "May 2017"
        school.city = "Baton Rouge"
        school.address = "3200 Woodland Ridge Blvd Baton Rouge, LA 70816 United States"
        return school
    }()
    
    let college: Education = {
        let school = Education()
        school.name = "Rhodes College"
        school.phone = 8008445969
        school.state = "Tennessee"
        school.state_abr = "TN"
        school.time = "August 2017 - Present"
        school.type = "College"
        school.website = "https://www.rhodes.edu"
        school.major = "Computer Science"
        school.location = GeoPoint(latitude: 35.155687, longitude: -89.988937)
        school.graduation = "May 2021"
        school.city = "Memphis"
        school.address = "2000 North Pkwy Memphis, TN 38112 United States"
        school.classes = "Computer Networks; Software Engineering; Graphics, Virtual Environments, and Human Computer Interaction; Databases; Distributed Systems; Computer Organization; Discrete Structures; Data Structures and Algorithms; Advanced Algorithms; Object Oriented Programming"
        return school
    }()
    
    fileprivate(set) var collectionView: UICollectionView
    
    let logoImage = UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate)
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
//        // View shadow
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
        
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
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderAndLogo()
        configureCollectionView()
        configureCollectionViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        isBlocked()
        let blocked = Blocked(target: self)
        blocked.isBlocked()
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        view.sendSubviewToBack(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ColorTheme.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .vertical
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width = view.frame.width
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func configureCollectionViewCells() {
        collectionView.register(AboutMeHeaderCell.self, forCellWithReuseIdentifier: AboutMeHeaderCell.reuseId)
        collectionView.register(AboutMeInfoCell.self, forCellWithReuseIdentifier: AboutMeInfoCell.reuseId)
        collectionView.register(AboutMeEducationCell.self, forCellWithReuseIdentifier: AboutMeEducationCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutMeHeaderCell.reuseId, for: indexPath) as! AboutMeHeaderCell
        let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutMeInfoCell.reuseId, for: indexPath) as! AboutMeInfoCell
        let eduCell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutMeEducationCell.reuseId, for: indexPath) as! AboutMeEducationCell
        
        if indexPath.row == 0 {
            
            headerCell.fullNameLabel.text = (user.first ?? "") + " " + (user.last ?? "")
            headerCell.descLabel.text = (user.summary ?? "")
            
            
            let objective = (user.objective ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.hyphenationFactor = 1
            paragraphStyle.lineSpacing = 1.3
            headerCell.objectiveLabel.attributedText = NSMutableAttributedString(string: objective, attributes: [
                .paragraphStyle : paragraphStyle,
                .foregroundColor: ColorTheme.blogTextColor
            ])
            
            headerCell.tap.addTarget(self, action: #selector(openWebsite))
            headerCell.linkedInButton.addTarget(self, action: #selector(openLinkedIn), for: .touchUpInside)
            headerCell.instagramButton.addTarget(self, action: #selector(instagramOptions), for: .touchUpInside)
            headerCell.resumeButton.addTarget(self, action: #selector(openResume), for: .touchUpInside)
            headerCell.emailButton.addTarget(self, action: #selector(openEmail), for: .touchUpInside)
            headerCell.phoneButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
            return headerCell
            
        } else if (indexPath.row == 1) {
            
            let size: CGFloat = 18
            if let pFirst = user.pFirst {
                let text = "Preferred to be called "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = pFirst
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.pName.label.attributedText = attributedString
            }
            
            if let stay = user.stay {
                let text = "Live in "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = stay
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.address.label.attributedText = attributedString
            }
            
            if let phone = user.phone {
                let phoneString = String(phone)
                let text = "Mobile "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = "\(formattedNumber(number: phoneString))"
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.phone.label.attributedText = attributedString
            }
            
            if let email = user.email {
                let text = "Primary email "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = email
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.email.label.attributedText = attributedString
            }
            
            if let birthday = user.birthday {
                let text = "Born on "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = birthday
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.birthday.label.attributedText = attributedString
            }
            
            if let college = college.name {
                let text = "Attending "
                var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]
                let attributedString = NSMutableAttributedString(string: text, attributes:attrs)
                
                let boldText = college
                attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .semibold)]
                let normalString = NSMutableAttributedString(string: boldText, attributes: attrs)
                attributedString.append(normalString)
                infoCell.school.label.attributedText = attributedString
            }
            
            infoCell.moreButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
            
            return infoCell
            
        } else {
            
            if let major = college.major {
                eduCell.header.text = major
            }
            
            if let time = college.time {
                eduCell.date.text = time
            }
            
            if let school = college.name {
                if let city = college.city {
                    if let state = college.state_abr {
                        eduCell.schoolInfo.text = "\(school), \(city), \(state)"
                    }
                }
            }
            
            if let graduation = college.graduation {
                eduCell.graduationInfo.textColor = ColorTheme.blue
                eduCell.graduationInfo.text = "Graduating in \(graduation)"
            }
            
            if let graduation = highschool.graduation {
                eduCell.highschoolDate.text = "Graduated in \(graduation)"
            }
            
            if let school = highschool.name {
                eduCell.highschoolHeader.text = "\(school)"
            }
            
            if let city = highschool.city {
                if let state_abr = highschool.state_abr {
                    eduCell.highSchoolInfo.text = "\(city), \(state_abr)"
                }
            }
            
            if let loc = college.location {
                if let school = college.name {
                    if let address = college.address {
                        let camera = GMSCameraPosition.camera(withLatitude: loc.latitude, longitude: loc.longitude, zoom: 15)
                        eduCell.collegeMapView.camera = camera

//                        // Creates a marker in the center of the map.
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
                        marker.title = "\(school)"
                        marker.snippet = "\(address)"
                        marker.map = eduCell.collegeMapView
                    }
                }
            }
            
            if let loc = highschool.location {
                if let school = highschool.name {
                    if let address = highschool.address {
                        let camera = GMSCameraPosition.camera(withLatitude: loc.latitude, longitude: loc.longitude, zoom: 15)
                        eduCell.highMapView.camera = camera

//                        // Creates a marker in the center of the map.
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
                        marker.title = "\(school)"
                        marker.snippet = "\(address)"
                        marker.map = eduCell.highMapView
                    }
                }
            }
            
            if let courses: String = college.classes {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 1
                paragraphStyle.alignment = .justified
                paragraphStyle.hyphenationFactor = 1
                
                let boldText = "Relevant Courses: "
                let attributedString = NSMutableAttributedString(string: boldText, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.foregroundColor: ColorTheme.blogTextColor
                ])
                
                let normText = courses
                let normalString = NSMutableAttributedString(string: normText.uppercased(), attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.foregroundColor: ColorTheme.blogTextColor
                ])
                
                attributedString.append(normalString)
                eduCell.courses.attributedText = attributedString
            }
            
            eduCell.tapCollege.addTarget(self, action: #selector(openMapC))
            eduCell.tapHighSchool.addTarget(self, action: #selector(openMapHS))
            eduCell.collegeWebButton.addTarget(self, action: #selector(openCWebsite), for: .touchUpInside)
            eduCell.highschoolButton.addTarget(self, action: #selector(openHSWebsite), for: .touchUpInside)
            
            return eduCell
        }
    }
    
    @objc private func openMapC() {
        if let loc = college.location {
            if let name = college.name {
                openMapForPlace(name: "\(name)", interest: .university, lat: loc.latitude, long: loc.longitude)
            }
        }
    }
    
    @objc private func openMapHS() {
        if let loc = highschool.location {
            if let name = highschool.name {
                openMapForPlace(name: "\(name)", interest: .school, lat: loc.latitude, long: loc.longitude)
            }
        }
    }
    
    @objc private func openLinkedIn() {
        if let urlString: String = user.linkedin {
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.preferredBarTintColor = ColorTheme.white
                vc.preferredControlTintColor = ColorTheme.blue
                vc.modalPresentationStyle = .automatic
                vc.dismissButtonStyle = .close
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func instagramOptions() {
        let popUp = UIAlertController(title: nil, message: "Which account do you want to see?", preferredStyle: .actionSheet)
        popUp.view.tintColor = ColorTheme.blue
        let subview = (popUp.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = .white
        popUp.addAction(UIAlertAction(title: "Portfolio", style: .default, handler: { (action) in
            if let urlString: String = self.user.portfolio {
                if let url = URL(string: urlString) {
                    let vc = SFSafariViewController(url: url)
                    vc.modalPresentationStyle = .automatic
                    vc.preferredBarTintColor = ColorTheme.white
                    vc.preferredControlTintColor = ColorTheme.blue
                    vc.dismissButtonStyle = .close
                    self.present(vc, animated: true)
                }
            }
        }))
        popUp.addAction(UIAlertAction(title: "Personal", style: .default, handler: { (action) in
            if let urlString: String = self.user.instagram {
                if let url = URL(string: urlString) {
                    let vc = SFSafariViewController(url: url)
                    vc.preferredBarTintColor = ColorTheme.white
                    vc.preferredControlTintColor = ColorTheme.blue
                    vc.modalPresentationStyle = .automatic
                    vc.dismissButtonStyle = .close
                    self.present(vc, animated: true)
                }
            }
        }))
        popUp.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(popUp, animated: true, completion: nil)
        
    }
    
    @objc private func openResume() {
        if let urlString: String = user.resume {
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.modalPresentationStyle = .automatic
                vc.preferredBarTintColor = ColorTheme.white
                vc.preferredControlTintColor = ColorTheme.blue
                vc.dismissButtonStyle = .close
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func openWebsite() {
        if let urlString: String = user.website {
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.preferredBarTintColor = ColorTheme.white
                vc.preferredControlTintColor = ColorTheme.blue
                vc.modalPresentationStyle = .automatic
                vc.dismissButtonStyle = .close
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func openHSWebsite() {
        if let urlString: String = highschool.website {
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.preferredBarTintColor = ColorTheme.white
                vc.preferredControlTintColor = ColorTheme.blue
                vc.modalPresentationStyle = .automatic
                vc.dismissButtonStyle = .close
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func openCWebsite() {
        if let urlString: String = college.website {
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.preferredBarTintColor = ColorTheme.white
                vc.preferredControlTintColor = ColorTheme.blue
                vc.modalPresentationStyle = .automatic
                vc.dismissButtonStyle = .close
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func callNumber() {
        if let phone: Int = self.user.phone {
            if let url = URL(string: "tel://+1\(phone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @objc private func openEmail() {
        if let email = user.email {
            let toRecipents = [email]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setToRecipients(toRecipents)
            present(mc, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+1 (XXX)-XXX-XXXX"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func openMapForPlace(name: String, interest: MKPointOfInterestCategory, lat: CLLocationDegrees, long: CLLocationDegrees) {
        let latitude:CLLocationDegrees =  lat
        let longitude:CLLocationDegrees =  long

        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 0.004, longitudinalMeters: 0.004)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
    
        mapItem.pointOfInterestCategory = interest
        mapItem.openInMaps(launchOptions: options)

    }
    
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
    }
}

class UserData: NSObject, NSDiscardableContent {
    var first: String!
    var last: String!
    var pFirst: String!
    var summary: String!
    var objective: String!
    var email: String!
    var phone: Int!
    var resume: String!
    var linkedin: String!
    var portfolio: String!
    var instagram: String!
    var website: String!
    var stay: String!
    var birthday: String!
    
    func beginContentAccess() -> Bool {
        return true
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
    
    func endContentAccess() {
    }
    
    func discardContentIfPossible() {
    }
}

class Education: NSObject, NSDiscardableContent {
    var phone: Int!
    var name: String!
    var address: String!
    var city: String!
    var state: String!
    var state_abr: String!
    var location: GeoPoint!
    var type: String!
    var graduation: String!
    var time: String!
    var website: String!
    var major: String?
    var classes: String?
    

    func beginContentAccess() -> Bool {
        return true
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
    
    func endContentAccess() {
    }
    
    func discardContentIfPossible() {
    }
}
