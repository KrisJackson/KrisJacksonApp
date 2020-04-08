//
//  BlogCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/1/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

import UIKit
import Firebase

class BlogCell: UICollectionViewCell {
    
    static let reuseId = "BlogCell"
    var dateTopAnchor: NSLayoutConstraint!
    let journal = UIImage(named: "Journal")?.withRenderingMode(.alwaysTemplate)
    let mag = UIImage(named: "Magazine")?.withRenderingMode(.alwaysTemplate)
    
    let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
//        // View shadow
//        view.layer.shadowRadius = 2
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    let bottomView: UILabel = {
        let view = UILabel()
        view.layer.borderColor = #colorLiteral(red: 0.79625386, green: 0.7957550883, blue: 0.8175097108, alpha: 1)
        view.layer.borderWidth = 1
        view.backgroundColor = ColorTheme.postBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImgContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorTheme.gray
        imageView.layer.borderColor = ColorTheme.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let date: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var blogIcon: UIButton = {
        let button = UIButton()
        button.setImage(journal, for: .normal)
        button.layer.cornerRadius = 17
        button.tintColor = ColorTheme.white
        button.backgroundColor = ColorTheme.red
        button.isUserInteractionEnabled = false
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
//        button.layer.borderWidth = 2.5
//        button.layer.borderColor = ColorTheme.white.cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let text: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .justified
        textView.textColor = ColorTheme.black
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let linkView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = ColorTheme.gray
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
        
        addSubview(bottomView)
        bottomView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        bottomView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(profileImgContainer)
        profileImgContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImgContainer.widthAnchor.constraint(equalTo: profileImgContainer.heightAnchor).isActive = true
        profileImgContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        profileImgContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profileImgContainer.addSubview(profileImage)
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: profileImgContainer.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: profileImgContainer.centerYAnchor).isActive = true
        setImage(imageView: profileImage, key: "profileImage")
        
        profileImgContainer.addSubview(blogIcon)
        profileImgContainer.bringSubviewToFront(blogIcon)
        blogIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        blogIcon.widthAnchor.constraint(equalTo: blogIcon.heightAnchor).isActive = true
        blogIcon.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -15).isActive = true
        blogIcon.centerXAnchor.constraint(equalTo: profileImage.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: profileImgContainer.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(text)
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        text.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        view.addSubview(date)
        date.centerXAnchor.constraint(equalTo: text.centerXAnchor).isActive = true
        date.leftAnchor.constraint(equalTo: text.leftAnchor, constant: 5).isActive = true
        date.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        dateTopAnchor = date.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 15)
        dateTopAnchor.isActive = true
    }
    
    func addLink() {
        blogIcon.backgroundColor = ColorTheme.purple
        blogIcon.setImage(mag, for: .normal)
        dateTopAnchor.isActive = false
        for view in linkView.subviews { view.removeFromSuperview() }
        view.addSubview(linkView)
        linkView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        linkView.leftAnchor.constraint(equalTo: date.leftAnchor).isActive = true
        linkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linkView.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10).isActive = true
        linkView.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -20).isActive = true
    }
    
    func removeLink() {
        blogIcon.backgroundColor = ColorTheme.red
        blogIcon.setImage(journal, for: .normal)
        linkView.removeFromSuperview()
        dateTopAnchor.isActive = true
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
    
    private func setImage(imageView: UIImageView, key: String) {
        Database.getUserListener { (snapshot, error) in
            if let snapshot = snapshot {
                if let reference: String = snapshot.data()?[key] as? String {
                    let profileImageReference: StorageReference = Storage.storage().reference(withPath: reference)
                    imageView.sd_setImage(with: profileImageReference, placeholderImage: nil)
                }
            }
        }
    }
}
