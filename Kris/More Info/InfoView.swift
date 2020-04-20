//
//  InfoView.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/19/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let body: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = ColorTheme.jobText
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = ColorTheme.black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(icon)
        icon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true
        
        addSubview(header)
        header.topAnchor.constraint(equalTo: topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        
        addSubview(body)
        body.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        body.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        body.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        
        addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: body.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: body.rightAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 18).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
