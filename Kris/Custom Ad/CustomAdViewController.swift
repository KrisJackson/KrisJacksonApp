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
        label.font = .systemFont(ofSize: 32, weight: .black)
        label.text = "I want to hear from you!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let message: Features = {
        let features = Features()
        let image = UIImage(systemName: "message.fill")?
            .withRenderingMode(.alwaysTemplate)
        features.icon.image = image
        features.header.text = "Message Me"
        features.body.text = "Feel free to message me by going to the message page and entering your name."
        features.translatesAutoresizingMaskIntoConstraints = false
        features.header.font = .systemFont(ofSize: 18, weight: .bold)
        return features
    }()
    
    let interests: Features = {
        let features = Features()
        let image = UIImage(systemName: "heart.fill")?
            .withRenderingMode(.alwaysTemplate)
        features.icon.image = image
        features.header.text = "Share Your Interests"
        features.body.text = "Learn more about my interests, and let me know if we share something in common."
        features.translatesAutoresizingMaskIntoConstraints = false
        features.header.font = .systemFont(ofSize: 18, weight: .bold)
        return features
    }()
    
    let blog: Features = {
        let features = Features()
        let image = UIImage(systemName: "doc.fill")?
            .withRenderingMode(.alwaysTemplate)
        features.icon.image = image
        features.header.text = "Respond To My Blogs"
        features.body.text = "Read my blog posts, and share your thoughts, ideas, and opinions with me."
        features.translatesAutoresizingMaskIntoConstraints = false
        features.header.font = .systemFont(ofSize: 18, weight: .bold)
        return features
    }()
    
    lazy var submit: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Dismiss", for: .normal)
        button.backgroundColor = ColorTheme.blue
        button.setTitleColor(ColorTheme.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        headerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        
        view.addSubview(message)
        message.leftAnchor.constraint(equalTo: headerLabel.leftAnchor).isActive = true
        message.rightAnchor.constraint(equalTo: headerLabel.rightAnchor).isActive = true
        message.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(interests)
        interests.leftAnchor.constraint(equalTo: message.leftAnchor).isActive = true
        interests.rightAnchor.constraint(equalTo: message.rightAnchor).isActive = true
        interests.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(blog)
        blog.leftAnchor.constraint(equalTo: message.leftAnchor).isActive = true
        blog.rightAnchor.constraint(equalTo: message.rightAnchor).isActive = true
        blog.topAnchor.constraint(equalTo: interests.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(submit)
        submit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submit.leftAnchor.constraint(equalTo: message.leftAnchor).isActive = true
        submit.rightAnchor.constraint(equalTo: message.rightAnchor).isActive = true
        submit.topAnchor.constraint(equalTo: blog.bottomAnchor, constant: 30).isActive = true
    }

    @objc private func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
}
