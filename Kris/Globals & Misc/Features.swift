//
//  Features.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/18/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class Features: UIView {
    
    var iconHeight: NSLayoutConstraint!
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let body: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.textAlignment = .left
        label.textColor = ColorTheme.jobText
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
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
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(icon)
        icon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true
        iconHeight = icon.heightAnchor.constraint(equalToConstant: 25)
        iconHeight.isActive = true
        
        addSubview(header)
        header.topAnchor.constraint(equalTo: topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        
        addSubview(body)
        body.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        body.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        body.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        body.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 3).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
