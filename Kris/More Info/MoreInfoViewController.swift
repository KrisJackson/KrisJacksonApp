//
//  MoreInfoViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/19/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contact: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Contact"
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let basic: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "General"
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let education: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Education"
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let social: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Social"
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phone: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "phone.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Mobile"
        infoView.header.text = "(225) 610-5747"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let pEmail: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "at")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Primary Email"
        infoView.header.text = "kristopherrjackson@gmail.com"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let name: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "person.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Full Name"
        infoView.header.text = "Kristopher Ryan Jackson"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let pName: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "person.circle.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Preferred Name"
        infoView.header.text = "Kris"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let date: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "gift.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Birthday"
        infoView.header.text = "July 3, 1998"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let born: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "house.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Born"
        infoView.header.text = "New Orleans, Louisiana"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let live: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "house")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Live"
        infoView.header.text = "Memphis, Tennessee"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let hSchool: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "studentdesk")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "High School"
        infoView.header.text = "Episcopal School of Baton Rouge"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let college: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "book.fill")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "College"
        infoView.header.text = "Rhodes College"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let major: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "rosette")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Major"
        infoView.header.text = "Computer Science"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let graduation: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "calendar")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Graduation Date"
        infoView.header.text = "May 2021"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let linkedIn: InfoView = {
        let infoView = InfoView()
        let image = UIImage(named: "LinkedIn")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "LinkedIn"
        infoView.header.text = "https://www.linkedin.com/in/kristopher-jackson-38a995162/"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let instagram: InfoView = {
        let infoView = InfoView()
        let image = UIImage(named: "Instagram")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Instagram"
        infoView.header.text = "https://www.instagram.com/kristopher.r.jackson/"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let pInstagram: InfoView = {
        let infoView = InfoView()
        let image = UIImage(named: "Instagram")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Instagram (Portfolio)"
        infoView.header.text = "https://www.instagram.com/krisjackson.portfolio/"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let website: InfoView = {
        let infoView = InfoView()
        let image = UIImage(systemName: "globe")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "Website"
        infoView.header.text = "https://www.kristopherjackson.com"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let github: InfoView = {
        let infoView = InfoView()
        let image = UIImage(named: "GitHub")?
            .withRenderingMode(.alwaysTemplate)
        infoView.icon.image = image
        infoView.body.text = "GitHub"
        infoView.header.text = "https://github.com/KrisJackson"
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: false)
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let spacing: CGFloat = 12
        view.addSubview(header)
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12).isActive = true
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(contact)
        contact.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        contact.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        contact.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(phone)
        phone.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        phone.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        phone.topAnchor.constraint(equalTo: contact.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(pEmail)
        pEmail.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        pEmail.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        pEmail.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(basic)
        basic.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        basic.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        basic.topAnchor.constraint(equalTo: pEmail.bottomAnchor, constant: 28).isActive = true
        
        scrollView.addSubview(name)
        name.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        name.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        name.topAnchor.constraint(equalTo: basic.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(pName)
        pName.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        pName.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        pName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(date)
        date.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        date.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        date.topAnchor.constraint(equalTo: pName.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(born)
        born.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        born.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        born.topAnchor.constraint(equalTo: date.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(live)
        live.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        live.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        live.topAnchor.constraint(equalTo: born.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(education)
        education.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        education.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        education.topAnchor.constraint(equalTo: live.bottomAnchor, constant: 28).isActive = true
        
        scrollView.addSubview(college)
        college.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        college.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        college.topAnchor.constraint(equalTo: education.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(major)
        major.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        major.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        major.topAnchor.constraint(equalTo: college.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(graduation)
        graduation.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        graduation.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        graduation.topAnchor.constraint(equalTo: major.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(hSchool)
        hSchool.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        hSchool.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        hSchool.topAnchor.constraint(equalTo: graduation.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(social)
        social.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        social.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        social.topAnchor.constraint(equalTo: hSchool.bottomAnchor, constant: 28).isActive = true
        
        scrollView.addSubview(website)
        website.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        website.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        website.topAnchor.constraint(equalTo: social.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(linkedIn)
        linkedIn.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        linkedIn.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        linkedIn.topAnchor.constraint(equalTo: website.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(instagram)
        instagram.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        instagram.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        instagram.topAnchor.constraint(equalTo: linkedIn.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(pInstagram)
        pInstagram.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        pInstagram.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        pInstagram.topAnchor.constraint(equalTo: instagram.bottomAnchor, constant: spacing).isActive = true
        
        scrollView.addSubview(github)
        github.leftAnchor.constraint(equalTo: contact.leftAnchor).isActive = true
        github.rightAnchor.constraint(equalTo: contact.rightAnchor).isActive = true
        github.topAnchor.constraint(equalTo: pInstagram.bottomAnchor, constant: spacing).isActive = true
        github.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
    }
}
