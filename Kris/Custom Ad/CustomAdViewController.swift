//
//  CustomAdViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/17/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class CustomAdViewController: UIViewController {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.blue
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Want your resume in an app?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 10
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Apps provide a fast and convenient way to share information with others. If you would like your resume in an app, reach out to me by going to the message page and sharing your thoughts."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerLabel)
        headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        
        view.addSubview(descLabel)
        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descLabel.leftAnchor.constraint(equalTo: headerLabel.leftAnchor).isActive = true
        descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
    }

}
