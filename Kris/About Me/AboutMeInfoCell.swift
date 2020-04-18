//
//  AboutMeInfoCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/22/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class AboutMeInfoCell: UICollectionViewCell {
    static let reuseId = "AboutMeInfoCell"
    
    let pName = InfoCell(iconName: "Name")
    let address = InfoCell(iconName: "Address")
    let phone = InfoCell(iconName: "Cell")
    let email = InfoCell(iconName: "Mail")
    let birthday = InfoCell(iconName: "Gift")
    let school = InfoCell(iconName: "University")
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Learn More About Me", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(ColorTheme.blue, for: .normal)
        button.backgroundColor = ColorTheme.aboutMeMoreBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        view.addSubview(birthday)
        birthday.translatesAutoresizingMaskIntoConstraints = false
        birthday.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthday.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        birthday.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(pName)
        pName.translatesAutoresizingMaskIntoConstraints = false
        pName.translatesAutoresizingMaskIntoConstraints = false
        pName.leftAnchor.constraint(equalTo: birthday.leftAnchor).isActive = true
        pName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pName.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 18).isActive = true
        
        view.addSubview(address)
        address.translatesAutoresizingMaskIntoConstraints = false
        address.leftAnchor.constraint(equalTo: pName.leftAnchor).isActive = true
        address.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        address.topAnchor.constraint(equalTo: pName.bottomAnchor, constant: 18).isActive = true

        view.addSubview(school)
        school.translatesAutoresizingMaskIntoConstraints = false
        school.leftAnchor.constraint(equalTo: address.leftAnchor).isActive = true
        school.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        school.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 18).isActive = true

        view.addSubview(phone)
        phone.translatesAutoresizingMaskIntoConstraints = false
        phone.leftAnchor.constraint(equalTo: school.leftAnchor).isActive = true
        phone.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phone.topAnchor.constraint(equalTo: school.bottomAnchor, constant: 18).isActive = true

        view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.leftAnchor.constraint(equalTo: phone.leftAnchor).isActive = true
        email.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 18).isActive = true

        view.addSubview(moreButton)
        moreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        moreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        moreButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        moreButton.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20).isActive = true

        view.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: moreButton.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: moreButton.rightAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 20).isActive = true
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
