//
//  MessageHeaderCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/4/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class MessageHeaderCell: UICollectionViewCell {
    static let reuseId = "MessageHeaderCell"
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = ColorTheme.aboutMeObjectiveBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Message Me!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 100
        label.text = "Feel free to message me anything through this page. I will try to respond within a reasonable amount of time."
        label.textColor = ColorTheme.jobText
        label.font = .systemFont(ofSize: 17, weight: .regular)
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
        
        view.addSubview(backView)
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        backView.addSubview(header)
        header.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
        header.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20).isActive = true
        header.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20).isActive = true
        
        backView.addSubview(text)
        text.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        text.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 2).isActive = true
        text.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        
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
