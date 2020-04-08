//
//  MessageCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/4/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    static let reuseId = "MessageCell"
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let highlightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorTheme.blue
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorTheme.jobText
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = ColorTheme.black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        view.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22).isActive = true
        
        view.addSubview(highlightView)
        highlightView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        highlightView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        highlightView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        highlightView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: highlightView.topAnchor, constant: 2).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: highlightView.rightAnchor, constant: 12).isActive = true
        
        view.addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(messageTextView)
        messageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: -5).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: highlightView.bottomAnchor, constant: 2).isActive = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        lbl.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left)
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height

        return layoutAttributes
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
