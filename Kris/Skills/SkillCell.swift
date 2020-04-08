//
//  SkillCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/27/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class SkillCell: UICollectionViewCell {
    
    static let reuseId = "SkillCell"
    
    var width: NSLayoutConstraint = NSLayoutConstraint()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = ColorTheme.black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBackground: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = ColorTheme.aboutMeMoreBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progress: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let new: UILabel = {
        let label = UILabel()
        label.text = "Decent"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let experienced: UILabel = {
        let label = UILabel()
        label.text = "Exceptional"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.addSubview(icon)
        icon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        icon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: icon.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualTo: icon.heightAnchor).isActive = true
        
        view.addSubview(progressBackground)
        progressBackground.heightAnchor.constraint(equalToConstant: 8).isActive = true
        progressBackground.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        progressBackground.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        progressBackground.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        
        progressBackground.addSubview(progress)
        progress.topAnchor.constraint(equalTo: progressBackground.topAnchor).isActive = true
        progress.leftAnchor.constraint(equalTo: progressBackground.leftAnchor).isActive = true
        progress.bottomAnchor.constraint(equalTo: progressBackground.bottomAnchor).isActive = true
        width = progress.widthAnchor.constraint(equalToConstant: 10)
        width.isActive = true
        
        view.addSubview(new)
        new.leftAnchor.constraint(equalTo: progressBackground.leftAnchor).isActive = true
        new.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        new.topAnchor.constraint(equalTo: progressBackground.bottomAnchor, constant: 6).isActive = true
        
        view.addSubview(experienced)
        experienced.widthAnchor.constraint(equalTo: new.widthAnchor).isActive = true
        experienced.leftAnchor.constraint(equalTo: new.rightAnchor).isActive = true
        experienced.rightAnchor.constraint(equalTo: progressBackground.rightAnchor).isActive = true
        experienced.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        experienced.topAnchor.constraint(equalTo: new.topAnchor).isActive = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        lbl.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left)
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
