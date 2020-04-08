//
//  WorkHeaderCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/25/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class WorkHeaderCell: UICollectionViewCell {
    
    static let reuseId = "WorkHeaderCell"
    
    let skills = UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
    let project = UIImage(named: "Project")?.withRenderingMode(.alwaysTemplate)
    
    let skillsTapped: UITapGestureRecognizer =  UITapGestureRecognizer()
    let projectTapped: UITapGestureRecognizer =  UITapGestureRecognizer()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var skillsBackground: UIView = {
        let view = UIView()
        view.addGestureRecognizer(skillsTapped)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = ColorTheme.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let skillsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var skillsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = skills
        imageView.tintColor = ColorTheme.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let skillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Skills"
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var projectBackground: UIView = {
        let view = UIView()
        view.addGestureRecognizer(projectTapped)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = ColorTheme.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let projectsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var projectsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = project
        imageView.tintColor = ColorTheme.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let projectsLabel: UILabel = {
        let label = UILabel()
        label.text = "Projects"
        label.textAlignment = .center
        label.textColor = ColorTheme.black
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
        
        view.addSubview(skillsBackground)
        skillsBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
        skillsBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        skillsBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        skillsBackground.addSubview(skillsContainer)
        skillsContainer.topAnchor.constraint(equalTo: skillsBackground.topAnchor).isActive = true
        skillsContainer.bottomAnchor.constraint(equalTo: skillsBackground.bottomAnchor).isActive = true
        skillsContainer.centerXAnchor.constraint(equalTo: skillsBackground.centerXAnchor).isActive = true
        skillsContainer.leftAnchor.constraint(equalTo: skillsBackground.leftAnchor, constant: 11).isActive = true

        skillsContainer.addSubview(skillsIcon)
        skillsIcon.widthAnchor.constraint(equalTo: skillsIcon.heightAnchor).isActive = true
        skillsIcon.leftAnchor.constraint(equalTo: skillsContainer.leftAnchor).isActive = true
        skillsIcon.centerYAnchor.constraint(equalTo: skillsContainer.centerYAnchor).isActive = true
        skillsIcon.topAnchor.constraint(equalTo: skillsContainer.topAnchor, constant: 10).isActive = true

        skillsContainer.addSubview(skillsLabel)
        skillsLabel.topAnchor.constraint(equalTo: skillsContainer.topAnchor).isActive = true
        skillsLabel.rightAnchor.constraint(equalTo: skillsContainer.rightAnchor).isActive = true
        skillsLabel.centerYAnchor.constraint(equalTo: skillsContainer.centerYAnchor).isActive = true
        skillsLabel.leftAnchor.constraint(equalTo: skillsIcon.rightAnchor, constant: 5).isActive = true
        
        view.addSubview(projectBackground)
        projectBackground.heightAnchor.constraint(equalTo: skillsBackground.heightAnchor).isActive = true
        projectBackground.centerYAnchor.constraint(equalTo: skillsBackground.centerYAnchor).isActive = true
        projectBackground.leftAnchor.constraint(equalTo: skillsBackground.rightAnchor, constant: 8).isActive = true
        
        projectBackground.addSubview(projectsContainer)
        projectsContainer.topAnchor.constraint(equalTo: projectBackground.topAnchor).isActive = true
        projectsContainer.bottomAnchor.constraint(equalTo: projectBackground.bottomAnchor).isActive = true
        projectsContainer.centerXAnchor.constraint(equalTo: projectBackground.centerXAnchor).isActive = true
        projectsContainer.leftAnchor.constraint(equalTo: projectBackground.leftAnchor, constant: 12).isActive = true

        projectsContainer.addSubview(projectsIcon)
        projectsIcon.widthAnchor.constraint(equalTo: projectsIcon.heightAnchor).isActive = true
        projectsIcon.leftAnchor.constraint(equalTo: projectsContainer.leftAnchor).isActive = true
        projectsIcon.centerYAnchor.constraint(equalTo: projectsContainer.centerYAnchor).isActive = true
        projectsIcon.topAnchor.constraint(equalTo: projectsContainer.topAnchor, constant: 11).isActive = true

        projectsContainer.addSubview(projectsLabel)
        projectsLabel.topAnchor.constraint(equalTo: projectsContainer.topAnchor).isActive = true
        projectsLabel.rightAnchor.constraint(equalTo: projectsContainer.rightAnchor).isActive = true
        projectsLabel.centerYAnchor.constraint(equalTo: projectsContainer.centerYAnchor).isActive = true
        projectsLabel.leftAnchor.constraint(equalTo: projectsIcon.rightAnchor, constant: 5).isActive = true
        
        view.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.leftAnchor.constraint(equalTo: skillsBackground.leftAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: skillsBackground.bottomAnchor, constant: 15).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6).isActive = true
        
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
    
    
    
//    let view: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    let skillsBackground: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 12
//        view.backgroundColor = ColorTheme.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        // View shadow
//        view.layer.shadowRadius = 3
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 1)
//        view.layer.shadowColor = ColorTheme.aboutMeEducationShadow.cgColor
//        return view
//    }()
//
//    let header: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 8
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let desc: UILabel = {
//        let label = UILabel()
//        label.textColor = ColorTheme.jobText
//        label.numberOfLines = 100
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let moreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 8
//        button.layer.masksToBounds = true
//        button.setTitleColor(ColorTheme.blue, for: .normal)
//        button.backgroundColor = ColorTheme.aboutMeMoreBackground
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
//        return button
//    }()
//
//    // created this label because of issues with dynamic cell sizing
//    // not visible to the users
//    let lbl: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        // not visible to users
//        addSubview(lbl)
//        lbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        lbl.heightAnchor.constraint(equalToConstant: 0).isActive = true
//
//        addSubview(view)
//        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//        view.addSubview(skillsBackground)
//        skillsBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
//        skillsBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
//        skillsBackground.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
//        skillsBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
//
//        skillsBackground.addSubview(header)
//        header.rightAnchor.constraint(equalTo: skillsBackground.rightAnchor, constant: -15).isActive = true
//        header.topAnchor.constraint(equalTo: skillsBackground.topAnchor, constant: 15).isActive = true
//        header.leftAnchor.constraint(equalTo: skillsBackground.leftAnchor, constant: 15).isActive = true
//
//        skillsBackground.addSubview(desc)
//        desc.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
//        desc.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
//        desc.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8).isActive = true
//
//        skillsBackground.addSubview(moreButton)
//        moreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        moreButton.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
//        moreButton.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
//        moreButton.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 10).isActive = true
//        moreButton.bottomAnchor.constraint(equalTo: skillsBackground.bottomAnchor, constant: -15).isActive = true
//    }
//
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        layoutIfNeeded()
//        lbl.preferredMaxLayoutWidth = (layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left)
//        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        return layoutAttributes
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
