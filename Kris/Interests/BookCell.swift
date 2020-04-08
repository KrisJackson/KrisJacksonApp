//
//  BookCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/29/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    static let reuseId = "BookCell"
    
    var descTop: NSLayoutConstraint!
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = ColorTheme.aboutMeEducationShadow.cgColor
        return view
    }()
    
    let imageShadow: UIView = {
        let view = UIView()
        // View shadow
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 0
        imageView.backgroundColor = ColorTheme.gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.textAlignment = .left
        label.textColor = ColorTheme.aboutMeDescriptionText
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Learn More", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(ColorTheme.blue, for: .normal)
        button.backgroundColor = ColorTheme.aboutMeMoreBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        return button
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
        
        view.addSubview(backView)
        backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        
        let height: CGFloat = 120
        backView.addSubview(imageShadow)
        imageShadow.heightAnchor.constraint(equalToConstant: height).isActive = true
        imageShadow.widthAnchor.constraint(equalToConstant: height/1.6).isActive = true
        imageShadow.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        imageShadow.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20).isActive = true
        imageShadow.bottomAnchor.constraint(lessThanOrEqualTo: backView.bottomAnchor, constant: -20).isActive = true
        
        imageShadow.addSubview(image)
        image.heightAnchor.constraint(equalToConstant: height).isActive = true
        image.widthAnchor.constraint(equalToConstant: height/1.6).isActive = true
        image.centerYAnchor.constraint(equalTo: imageShadow.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: imageShadow.centerXAnchor).isActive = true

        backView.addSubview(header)
        header.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
        header.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 20).isActive = true
        header.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20).isActive = true
    }
    
    func subHeaderAdded() {
        backView.addSubview(subHeader)
        subHeader.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        subHeader.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        subHeader.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 2).isActive = true
        
        backView.addSubview(desc)
        desc.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        desc.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        desc.topAnchor.constraint(equalTo: subHeader.bottomAnchor, constant: 2).isActive = true
        
        view.addSubview(moreButton)
        moreButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        moreButton.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
        moreButton.topAnchor.constraint(greaterThanOrEqualTo: desc.bottomAnchor, constant: 20).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
    }
    
    func descAdded() {
        backView.addSubview(desc)
        desc.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        desc.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        desc.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 2).isActive = true
        
        view.addSubview(moreButton)
        moreButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        moreButton.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
        moreButton.topAnchor.constraint(greaterThanOrEqualTo: desc.bottomAnchor, constant: 20).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
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
