//
//  HeaderCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/30/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import LinkPresentation

class FavHeaderCell: UICollectionViewCell {
    
    static let reuseId = "FavHeader"
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = ColorTheme.aboutMeMoreBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // created this label because of issues with dynamic cell sizing
    // not visible to the users
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // not visible to users
        addSubview(lbl)
        lbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(iconBackground)
        iconBackground.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iconBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        iconBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        iconBackground.widthAnchor.constraint(equalTo: iconBackground.heightAnchor).isActive = true
        
        iconBackground.addSubview(iconImage)
        iconImage.centerXAnchor.constraint(equalTo: iconBackground.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: iconBackground.topAnchor, constant: 14).isActive = true
        iconImage.leftAnchor.constraint(equalTo: iconBackground.leftAnchor, constant: 14).isActive = true
        
        view.addSubview(header)
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: iconBackground.bottomAnchor, constant: 8).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        header.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        lbl.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left)
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
