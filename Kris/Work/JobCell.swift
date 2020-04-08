//
//  JobCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/25/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit

class JobCell: UICollectionViewCell {
    static let reuseId = "JobCell"
    
    let code = UIImage(named: "Code")?.withRenderingMode(.alwaysTemplate)
    let toolsIcon = UIImage(named: "Tools")?.withRenderingMode(.alwaysTemplate)
    let durationIcon = UIImage(named: "Duration")?.withRenderingMode(.alwaysTemplate)
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let jobBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = ColorTheme.aboutMeEducationShadow.cgColor
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = ColorTheme.aboutMeBackgroundView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    let profileImgContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.backgroundColor = ColorTheme.white
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
        imageView.layer.cornerRadius = 46.5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorTheme.gray
        imageView.layer.borderColor = ColorTheme.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let company: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let job: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toolHeader: UILabel = {
        let label = UILabel()
        label.text = "Languages & Tools"
        label.numberOfLines = 10
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.jobText
        label.numberOfLines = 100
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tools: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.jobText
        label.numberOfLines = 100
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.aboutMeSeporator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = code
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var jobImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = toolsIcon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let durationHeader: UILabel = {
        let label = UILabel()
        label.text = "Job Length"
        label.numberOfLines = 10
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let duration: UILabel = {
        let label = UILabel()
        label.textColor = ColorTheme.jobText
        label.numberOfLines = 100
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var durationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = durationIcon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        view.addSubview(jobBackground)
        jobBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jobBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        jobBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        jobBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6).isActive = true
        
        jobBackground.addSubview(backgroundImage)
        backgroundImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: jobBackground.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: jobBackground.leftAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: jobBackground.centerXAnchor).isActive = true
        
        jobBackground.addSubview(profileImgContainer)
        profileImgContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImgContainer.centerXAnchor.constraint(equalTo: jobBackground.centerXAnchor).isActive = true
        profileImgContainer.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
        profileImgContainer.widthAnchor.constraint(equalTo: profileImgContainer.heightAnchor).isActive = true
        
        profileImgContainer.addSubview(profileImage)
        profileImage.heightAnchor.constraint(equalToConstant: 93).isActive = true
        profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: profileImgContainer.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: profileImgContainer.centerYAnchor).isActive = true
        
        jobBackground.addSubview(company)
        company.centerXAnchor.constraint(equalTo: jobBackground.centerXAnchor).isActive = true
        company.leftAnchor.constraint(equalTo: jobBackground.leftAnchor, constant: 20).isActive = true
        company.topAnchor.constraint(equalTo: profileImgContainer.bottomAnchor, constant: 12).isActive = true
        
        jobBackground.addSubview(location)
        location.centerXAnchor.constraint(equalTo: jobBackground.centerXAnchor).isActive = true
        location.topAnchor.constraint(equalTo: company.bottomAnchor, constant: 2).isActive = true
        location.leftAnchor.constraint(equalTo: jobBackground.leftAnchor, constant: 20).isActive = true
        
        jobBackground.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.leftAnchor.constraint(equalTo: jobBackground.leftAnchor, constant: 40).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: jobBackground.centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 15).isActive = true
        
        jobBackground.addSubview(jobImageView)
        jobImageView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 15).isActive = true
        jobImageView.leftAnchor.constraint(equalTo: jobBackground.leftAnchor, constant: 20).isActive = true
        jobImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        jobImageView.widthAnchor.constraint(equalTo: jobImageView.heightAnchor).isActive = true
        
        jobBackground.addSubview(job)
        job.rightAnchor.constraint(equalTo: jobBackground.rightAnchor, constant: -20).isActive = true
        job.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 15).isActive = true
        job.leftAnchor.constraint(equalTo: jobImageView.rightAnchor, constant: 15).isActive = true
        
        jobBackground.addSubview(desc)
        desc.topAnchor.constraint(equalTo: job.bottomAnchor, constant: 3).isActive = true
        desc.leftAnchor.constraint(equalTo: job.leftAnchor).isActive = true
        desc.rightAnchor.constraint(equalTo: job.rightAnchor).isActive = true
        
        jobBackground.addSubview(toolsImageView)
        toolsImageView.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 12).isActive = true
        toolsImageView.leftAnchor.constraint(equalTo: jobImageView.leftAnchor).isActive = true
        toolsImageView.heightAnchor.constraint(equalTo: jobImageView.heightAnchor).isActive = true
        toolsImageView.widthAnchor.constraint(equalTo: toolsImageView.heightAnchor).isActive = true
        
        jobBackground.addSubview(toolHeader)
        toolHeader.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
        toolHeader.topAnchor.constraint(equalTo: toolsImageView.topAnchor).isActive = true
        toolHeader.leftAnchor.constraint(equalTo: job.leftAnchor).isActive = true
        
        jobBackground.addSubview(tools)
        tools.topAnchor.constraint(equalTo: toolHeader.bottomAnchor, constant: 3).isActive = true
        tools.rightAnchor.constraint(equalTo: toolHeader.rightAnchor).isActive = true
        tools.leftAnchor.constraint(equalTo: toolHeader.leftAnchor).isActive = true
        
        jobBackground.addSubview(durationImageView)
        durationImageView.topAnchor.constraint(equalTo: tools.bottomAnchor, constant: 12).isActive = true
        durationImageView.leftAnchor.constraint(equalTo: jobImageView.leftAnchor).isActive = true
        durationImageView.heightAnchor.constraint(equalTo: jobImageView.heightAnchor).isActive = true
        durationImageView.widthAnchor.constraint(equalTo: jobImageView.heightAnchor).isActive = true
        
        jobBackground.addSubview(durationHeader)
        durationHeader.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
        durationHeader.topAnchor.constraint(equalTo: durationImageView.topAnchor).isActive = true
        durationHeader.leftAnchor.constraint(equalTo: job.leftAnchor).isActive = true
        
        jobBackground.addSubview(duration)
        duration.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true
        duration.leftAnchor.constraint(equalTo: durationHeader.leftAnchor).isActive = true
        duration.topAnchor.constraint(equalTo: durationHeader.bottomAnchor, constant: 3).isActive = true
        duration.bottomAnchor.constraint(equalTo: jobBackground.bottomAnchor, constant: -20).isActive = true
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
