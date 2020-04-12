//
//  InboxCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/11/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class InboxCell: UICollectionViewCell {
    static let reuseId = "InboxCell"
    
    let view: UIView = {
        let view = UIView()
//        view.layer.borderColor = #colorLiteral(red: 0.79625386, green: 0.7957550883, blue: 0.8175097108, alpha: 1)
//        view.layer.borderWidth = 1
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.blue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.jobText
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .regular)
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
        backgroundColor = ColorTheme.postBackground
        addSubview(lbl)
        lbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0.5).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0.5).isActive = true
        
        view.addSubview(name)
        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(date)
        date.heightAnchor.constraint(greaterThanOrEqualToConstant: 18).isActive = true
        date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2).isActive = true
        date.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        date.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(message)
        message.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        message.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 12).isActive = true
        message.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        message.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        message.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
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
