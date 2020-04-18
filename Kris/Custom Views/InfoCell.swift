//
//  InfoCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/27/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class InfoCell: UIView {
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(iconName: String) {
        super.init(frame: CGRect.zero)
        backgroundColor = ColorTheme.white
        
        addSubview(icon)
        icon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true
        
        addSubview(label)
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: icon.topAnchor).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualTo: icon.heightAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12).isActive = true
        
        let iconImage = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        icon.image = iconImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
