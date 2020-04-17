//
//  AboutMeEducationCell.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/23/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class AboutMeEducationCell: UICollectionViewCell {
    static let reuseId = "AboutMeEducationCell"
    
    let tapCollege: UITapGestureRecognizer = UITapGestureRecognizer()
    let tapHighSchool: UITapGestureRecognizer = UITapGestureRecognizer()
    let school = UIImage(named: "School")?.withRenderingMode(.alwaysTemplate)
    let scroll = UIImage(named: "Scroll")?.withRenderingMode(.alwaysTemplate)
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let educationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        view.layer.shadowColor = ColorTheme.aboutMeEducationShadow.cgColor
        
        return view
    }()
    
    let educationIconBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22.5
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = school
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let schoolInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var courses: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.textColor = ColorTheme.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let graduationInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = ColorTheme.blue
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highschoolDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highschoolEducationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // View shadow
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        view.layer.shadowColor = ColorTheme.aboutMeEducationShadow.cgColor
        
        return view
    }()
    
    let highschoolHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highSchoolInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highIconBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22.5
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = scroll
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let collegeWebButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Visit Website", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(ColorTheme.blue, for: .normal)
        button.backgroundColor = ColorTheme.aboutMeMoreBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    let highschoolButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Visit Website", for: .normal)
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
    
    lazy var collegeMapView: GMSMapView = {
        let map = GMSMapView()
        map.layer.cornerRadius = 8
        map.layer.borderWidth = 0.2
        map.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        map.isUserInteractionEnabled = false
        map.translatesAutoresizingMaskIntoConstraints = false
        
        do {
          // Set the map style by passing a valid JSON string.
          map.mapStyle = try GMSMapStyle(jsonString: mapStyle)
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        return map
    }()
    
    lazy var collegeTouchView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(tapCollege)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var highMapView: GMSMapView = {
        let map = GMSMapView()
        map.layer.cornerRadius = 8
        map.layer.borderWidth = 0.2
        map.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        map.isUserInteractionEnabled = false
        map.translatesAutoresizingMaskIntoConstraints = false
        
        do {
          // Set the map style by passing a valid JSON string.
          map.mapStyle = try GMSMapStyle(jsonString: mapStyle)
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        return map
    }()
    
    lazy var highTouchView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(tapHighSchool)
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
        
        view.addSubview(date)
        date.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        date.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        date.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(educationView)
        educationView.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20).isActive = true
        educationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        educationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        educationView.addSubview(educationIconBackground)
        educationIconBackground.heightAnchor.constraint(equalToConstant: 45).isActive = true
        educationIconBackground.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        educationIconBackground.topAnchor.constraint(equalTo: educationView.topAnchor, constant: 20).isActive = true
        educationIconBackground.widthAnchor.constraint(equalTo: educationIconBackground.heightAnchor).isActive = true
        
        educationIconBackground.addSubview(iconImage)
        iconImage.centerXAnchor.constraint(equalTo: educationIconBackground.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: educationIconBackground.centerYAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: educationIconBackground.topAnchor, constant: 8).isActive = true
        iconImage.leftAnchor.constraint(equalTo: educationIconBackground.leftAnchor, constant: 8).isActive = true
        
        educationView.addSubview(header)
        header.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 20).isActive = true
        header.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 20).isActive = true
        
        educationView.addSubview(schoolInfo)
        schoolInfo.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        schoolInfo.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 2).isActive = true
        schoolInfo.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 30).isActive = true
        
        educationView.addSubview(courses)
        courses.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        courses.topAnchor.constraint(equalTo: schoolInfo.bottomAnchor, constant: 20).isActive = true
        courses.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 20).isActive = true
        
        educationView.addSubview(graduationInfo)
        graduationInfo.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        graduationInfo.topAnchor.constraint(equalTo: courses.bottomAnchor, constant: 12).isActive = true
        graduationInfo.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 20).isActive = true
        
        educationView.addSubview(collegeMapView)
        collegeMapView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        collegeMapView.topAnchor.constraint(equalTo: graduationInfo.bottomAnchor, constant: 12).isActive = true
        collegeMapView.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        collegeMapView.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 20).isActive = true
        
        educationView.addSubview(collegeTouchView)
        educationView.bringSubviewToFront(collegeTouchView)
        collegeTouchView.heightAnchor.constraint(equalTo: collegeMapView.heightAnchor).isActive = true
        collegeTouchView.topAnchor.constraint(equalTo: collegeMapView.topAnchor).isActive = true
        collegeTouchView.centerXAnchor.constraint(equalTo: collegeMapView.centerXAnchor).isActive = true
        collegeTouchView.leftAnchor.constraint(equalTo: collegeMapView.leftAnchor).isActive = true
        
        educationView.addSubview(collegeWebButton)
        collegeWebButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        collegeWebButton.topAnchor.constraint(equalTo: collegeMapView.bottomAnchor, constant: 20).isActive = true
        collegeWebButton.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        collegeWebButton.leftAnchor.constraint(equalTo: educationView.leftAnchor, constant: 20).isActive = true
        collegeWebButton.bottomAnchor.constraint(equalTo: educationView.bottomAnchor, constant: -20).isActive = true
        
        educationView.addSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: educationView.centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: educationView.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(highschoolDate)
        highschoolDate.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20).isActive = true
        highschoolDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        highschoolDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        view.addSubview(highschoolEducationView)
        highschoolEducationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        highschoolEducationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        highschoolEducationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        highschoolEducationView.topAnchor.constraint(equalTo: highschoolDate.bottomAnchor, constant: 20).isActive = true
        
        highschoolEducationView.addSubview(highIconBackground)
        highIconBackground.heightAnchor.constraint(equalToConstant: 45).isActive = true
        highIconBackground.centerXAnchor.constraint(equalTo: highschoolEducationView.centerXAnchor).isActive = true
        highIconBackground.topAnchor.constraint(equalTo: highschoolEducationView.topAnchor, constant: 20).isActive = true
        highIconBackground.widthAnchor.constraint(equalTo: highIconBackground.heightAnchor).isActive = true
        
        highIconBackground.addSubview(hIconImage)
        hIconImage.centerXAnchor.constraint(equalTo: highIconBackground.centerXAnchor).isActive = true
        hIconImage.centerYAnchor.constraint(equalTo: highIconBackground.centerYAnchor).isActive = true
        hIconImage.topAnchor.constraint(equalTo: highIconBackground.topAnchor, constant: 8).isActive = true
        hIconImage.leftAnchor.constraint(equalTo: highIconBackground.leftAnchor, constant: 8).isActive = true
        
        highschoolEducationView.addSubview(highschoolHeader)
        highschoolHeader.centerXAnchor.constraint(equalTo: highschoolEducationView.centerXAnchor).isActive = true
        highschoolHeader.topAnchor.constraint(equalTo: hIconImage.bottomAnchor, constant: 20).isActive = true
        highschoolHeader.leftAnchor.constraint(equalTo: highschoolEducationView.leftAnchor, constant: 20).isActive = true
        
        highschoolEducationView.addSubview(highSchoolInfo)
        highSchoolInfo.centerXAnchor.constraint(equalTo: highschoolEducationView.centerXAnchor).isActive = true
        highSchoolInfo.topAnchor.constraint(equalTo: highschoolHeader.bottomAnchor, constant: 2).isActive = true
        highSchoolInfo.leftAnchor.constraint(equalTo: highschoolEducationView.leftAnchor, constant: 20).isActive = true
        
        highschoolEducationView.addSubview(highMapView)
        highMapView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        highMapView.topAnchor.constraint(equalTo: highSchoolInfo.bottomAnchor, constant: 20).isActive = true
        highMapView.centerXAnchor.constraint(equalTo: highschoolEducationView.centerXAnchor).isActive = true
        highMapView.leftAnchor.constraint(equalTo: highschoolEducationView.leftAnchor, constant: 20).isActive = true
        
        highschoolEducationView.addSubview(highTouchView)
        highschoolEducationView.bringSubviewToFront(highTouchView)
        highTouchView.heightAnchor.constraint(equalTo: highMapView.heightAnchor).isActive = true
        highTouchView.topAnchor.constraint(equalTo: highMapView.topAnchor).isActive = true
        highTouchView.centerXAnchor.constraint(equalTo: highMapView.centerXAnchor).isActive = true
        highTouchView.leftAnchor.constraint(equalTo: highMapView.leftAnchor).isActive = true
        
        highschoolEducationView.addSubview(highschoolButton)
        highschoolButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        highschoolButton.topAnchor.constraint(equalTo: highMapView.bottomAnchor, constant: 20).isActive = true
        highschoolButton.centerXAnchor.constraint(equalTo: highschoolEducationView.centerXAnchor).isActive = true
        highschoolButton.leftAnchor.constraint(equalTo: highschoolEducationView.leftAnchor, constant: 20).isActive = true
        highschoolButton.bottomAnchor.constraint(equalTo: highschoolEducationView.bottomAnchor, constant: -20).isActive = true
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
