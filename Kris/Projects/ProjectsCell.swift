//
//  ProjectsCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/28/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class ProjectsCell: UICollectionViewCell {
    static let reuseId = "ProjectCell"
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let line: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let projectBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languages: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.black
        label.numberOfLines = 100
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let project: Features = {
        let features = Features()
        features.tintColor = ColorTheme.black
        features.translatesAutoresizingMaskIntoConstraints = false
        features.header.font = .systemFont(ofSize: 18, weight: .bold)
        return features
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
        view.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(line)
        line.widthAnchor.constraint(equalToConstant: 0).isActive = true
        line.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(projectBackground)
        projectBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        projectBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        projectBackground.leftAnchor.constraint(equalTo: line.rightAnchor, constant: 0).isActive = true
        
        projectBackground.addSubview(project)
        project.iconHeight.constant = 38
        project.centerXAnchor.constraint(equalTo: projectBackground.centerXAnchor).isActive = true
        project.topAnchor.constraint(equalTo: projectBackground.topAnchor).isActive = true
        project.leftAnchor.constraint(equalTo: projectBackground.leftAnchor).isActive = true

        projectBackground.addSubview(languages)
        languages.leftAnchor.constraint(equalTo: project.header.leftAnchor).isActive = true
        languages.topAnchor.constraint(equalTo: project.bottomAnchor, constant: 3).isActive = true
        languages.centerXAnchor.constraint(equalTo: projectBackground.centerXAnchor).isActive = true
        languages.bottomAnchor.constraint(equalTo: projectBackground.bottomAnchor).isActive = true
        
        view.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: projectBackground.centerXAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: projectBackground.leftAnchor, constant: 0).isActive = true
        separatorView.topAnchor.constraint(equalTo: projectBackground.bottomAnchor, constant: 20).isActive = true
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
