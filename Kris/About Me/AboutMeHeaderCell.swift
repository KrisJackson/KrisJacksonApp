//
//  AboutMeHeaderCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/22/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class AboutMeHeaderCell: UICollectionViewCell {
    static let reuseId = "AboutMeHeaderCell"
    
    let web = UIImage(named: "Info")?.withRenderingMode(.alwaysTemplate)
    let phone = UIImage(named: "Phone")?.withRenderingMode(.alwaysTemplate)
    let linkedIn = UIImage(named: "LinkedIn")?.withRenderingMode(.alwaysTemplate)
    let instagram = UIImage(named: "Instagram")?.withRenderingMode(.alwaysTemplate)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = ColorTheme.aboutMeBackgroundView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    let profilePictureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 5
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorTheme.gray
        imageView.layer.borderColor = ColorTheme.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .center
        label.textColor = ColorTheme.aboutMeDescriptionText
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        button.tintColor = ColorTheme.white
        button.backgroundColor = ColorTheme.green
        button.layer.borderColor = ColorTheme.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Image icon
        button.setImage(phone, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 8.5, left: 8.5, bottom: 8.5, right: 8.5)
        return button
    }()
    
    lazy var linkedInButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.tintColor = ColorTheme.black
        button.backgroundColor = ColorTheme.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Image icon
        button.setImage(linkedIn, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    lazy var instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.tintColor = ColorTheme.black
        button.backgroundColor = ColorTheme.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Image icon
        button.setImage(instagram, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    lazy var websiteBackground: UIView = {
        let view = UIView()
        view.addGestureRecognizer(tap)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let websiteContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var websiteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = web
        imageView.tintColor = ColorTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "Learn More"
        label.textAlignment = .center
        label.textColor = ColorTheme.white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let objectiveBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = ColorTheme.aboutMeObjectiveBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let objectiveHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Career Objective"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let objectiveLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1000
        label.textAlignment = .left
        label.textColor = ColorTheme.aboutMeDescriptionText
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Email", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = ColorTheme.gray
        button.setTitleColor(ColorTheme.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    let resumeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Resume", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(ColorTheme.white, for: .normal)
        button.backgroundColor = ColorTheme.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    let separatorView2: UIView = {
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
        
        view.addSubview(backgroundImage)
        backgroundImage.heightAnchor.constraint(equalToConstant: 220).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(profilePictureImage)
        profilePictureImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        profilePictureImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePictureImage.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
        profilePictureImage.widthAnchor.constraint(equalTo: profilePictureImage.heightAnchor).isActive = true
        
        view.addSubview(phoneButton)
        phoneButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        phoneButton.widthAnchor.constraint(equalTo: phoneButton.heightAnchor).isActive = true
        phoneButton.bottomAnchor.constraint(equalTo: profilePictureImage.bottomAnchor, constant: -10).isActive = true
        phoneButton.centerXAnchor.constraint(equalTo: profilePictureImage.rightAnchor, constant: -35).isActive = true
        
        view.addSubview(fullNameLabel)
        fullNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        fullNameLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: profilePictureImage.bottomAnchor, constant: 12).isActive = true
        
        view.addSubview(descLabel)
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        descLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 6).isActive = true
        
        view.addSubview(websiteBackground)
        websiteBackground.heightAnchor.constraint(equalToConstant: 42).isActive = true
        websiteBackground.leftAnchor.constraint(equalTo: descLabel.leftAnchor).isActive = true
        websiteBackground.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24).isActive = true
        
        websiteBackground.addSubview(websiteContainer)
        websiteContainer.topAnchor.constraint(equalTo: websiteBackground.topAnchor).isActive = true
        websiteContainer.bottomAnchor.constraint(equalTo: websiteBackground.bottomAnchor).isActive = true
        websiteContainer.centerXAnchor.constraint(equalTo: websiteBackground.centerXAnchor).isActive = true
        
        websiteContainer.addSubview(websiteIcon)
        websiteIcon.widthAnchor.constraint(equalTo: websiteIcon.heightAnchor).isActive = true
        websiteIcon.leftAnchor.constraint(equalTo: websiteContainer.leftAnchor).isActive = true
        websiteIcon.centerYAnchor.constraint(equalTo: websiteContainer.centerYAnchor).isActive = true
        websiteIcon.topAnchor.constraint(equalTo: websiteContainer.topAnchor, constant: 12).isActive = true

        websiteContainer.addSubview(websiteLabel)
        websiteLabel.topAnchor.constraint(equalTo: websiteContainer.topAnchor).isActive = true
        websiteLabel.rightAnchor.constraint(equalTo: websiteContainer.rightAnchor).isActive = true
        websiteLabel.centerYAnchor.constraint(equalTo: websiteContainer.centerYAnchor).isActive = true
        websiteLabel.leftAnchor.constraint(equalTo: websiteIcon.rightAnchor, constant: 5).isActive = true
        
        view.addSubview(linkedInButton)
        linkedInButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        linkedInButton.heightAnchor.constraint(equalTo: websiteBackground.heightAnchor).isActive = true
        linkedInButton.centerYAnchor.constraint(equalTo: websiteBackground.centerYAnchor).isActive = true
        linkedInButton.leftAnchor.constraint(equalTo: websiteBackground.rightAnchor, constant: 6).isActive = true
        
        view.addSubview(instagramButton)
        instagramButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        instagramButton.rightAnchor.constraint(equalTo: descLabel.rightAnchor).isActive = true
        instagramButton.heightAnchor.constraint(equalTo: websiteBackground.heightAnchor).isActive = true
        instagramButton.centerYAnchor.constraint(equalTo: websiteBackground.centerYAnchor).isActive = true
        instagramButton.leftAnchor.constraint(equalTo: linkedInButton.rightAnchor, constant: 6).isActive = true
        
        view.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.leftAnchor.constraint(equalTo: descLabel.leftAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: websiteBackground.bottomAnchor, constant: 12).isActive = true
        
        view.addSubview(objectiveBackground)
        objectiveBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        objectiveBackground.leftAnchor.constraint(equalTo: descLabel.leftAnchor).isActive = true
        objectiveBackground.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 15).isActive = true
        
        objectiveBackground.addSubview(objectiveHeaderLabel)
        objectiveHeaderLabel.centerXAnchor.constraint(equalTo: objectiveBackground.centerXAnchor).isActive = true
        objectiveHeaderLabel.leftAnchor.constraint(equalTo: objectiveBackground.leftAnchor, constant: 20).isActive = true
        objectiveHeaderLabel.topAnchor.constraint(equalTo: objectiveBackground.topAnchor, constant: 20).isActive = true
        
        objectiveBackground.addSubview(objectiveLabel)
        objectiveLabel.leftAnchor.constraint(equalTo: objectiveHeaderLabel.leftAnchor).isActive = true
        objectiveLabel.centerXAnchor.constraint(equalTo: objectiveHeaderLabel.centerXAnchor).isActive = true
        objectiveLabel.topAnchor.constraint(equalTo: objectiveHeaderLabel.bottomAnchor, constant: 5).isActive = true
        
        objectiveBackground.addSubview(emailButton)
        emailButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        emailButton.leftAnchor.constraint(equalTo: objectiveLabel.leftAnchor).isActive = true
        emailButton.topAnchor.constraint(equalTo: objectiveLabel.bottomAnchor, constant: 15).isActive = true
        emailButton.bottomAnchor.constraint(equalTo: objectiveBackground.bottomAnchor, constant: -20).isActive = true
        
        objectiveBackground.addSubview(resumeButton)
        resumeButton.widthAnchor.constraint(equalTo: emailButton.widthAnchor).isActive = true
        resumeButton.heightAnchor.constraint(equalTo: emailButton.heightAnchor).isActive = true
        resumeButton.rightAnchor.constraint(equalTo: objectiveLabel.rightAnchor).isActive = true
        resumeButton.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        resumeButton.leftAnchor.constraint(equalTo: emailButton.rightAnchor, constant: 6).isActive = true
        
        view.addSubview(separatorView2)
        separatorView2.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView2.leftAnchor.constraint(equalTo: descLabel.leftAnchor).isActive = true
        separatorView2.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
        separatorView2.topAnchor.constraint(equalTo: objectiveBackground.bottomAnchor, constant: 15).isActive = true
        separatorView2.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setImage(imageView: profilePictureImage, key: "profileImage")
        setImage(imageView: backgroundImage, key: "backgroundImage")
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
