//
//  SkillsViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/27/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class SkillsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate(set) var collectionView: UICollectionView
    
    lazy var one: CGFloat = (view.frame.width - 100) * (1 / 4)
    lazy var two: CGFloat = (view.frame.width - 100) * (2 / 4)
    lazy var three: CGFloat = (view.frame.width - 100) * (3 / 4)
    lazy var four: CGFloat = (view.frame.width - 100)
    
    let lang = ["Swift", "Python", "C, C++, C#", "HTML/CSS", "LAMP Stack", "SQL", "NoSQL", "Node.js", "Rust", "Go", "RISC Assembly Language"]
    lazy var langScore = [
        "Swift": four, "Python": four, "C, C++, C#": four, "HTML/CSS": four, "LAMP Stack": three, "SQL": three, "NoSQL": three, "Node.js": two, "Rust": one, "Go": one, "RISC Assembly Language": one]
    let langIcon = ["Swift", "Python", "C", "HTML", "PHP", "SQL", "NoSQL", "JS", "Rust", "Go", "RISC"]
    
    
    let areas = ["iOS Development", "iOS Frameworks and SDKs", "Web Development", "API Design", "Computer Networking", "Machine Learning", "VR and Game Development"]
    lazy var areasScore = ["iOS Development": four, "iOS Frameworks and SDKs": four, "Web Development": four, "API Design": four, "Computer Networking": three, "Machine Learning": two, "VR and Game Development": two]
    let areasIcon = ["iOS", "SDK", "WebDev", "API", "Net", "ML", "VR"]
    
    let os = ["MacOS", "Linux", "Windows"]
    lazy var osScore = ["MacOS": four, "Linux": three, "Windows": three]
    let osIcon = ["Mac", "Linux", "Windows"]
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Skills"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let exit: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = ColorTheme.blue
        button.backgroundColor = ColorTheme.white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12).isActive = true
        
        configureCollectionView()
        configureCollectionViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let blocked = Blocked(target: self)
        blocked.isBlocked()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        view.sendSubviewToBack(collectionView)
        collectionView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ColorTheme.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .vertical
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width = view.frame.width
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func configureCollectionViewCells() {
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseId)
        collectionView.register(SkillCellHeader.self, forCellWithReuseIdentifier: SkillCellHeader.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lang.count + areas.count + os.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCellHeader.reuseId, for: indexPath) as! SkillCellHeader
        let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCell.reuseId, for: indexPath) as! SkillCell
        
        if (indexPath.row < lang.count) {
            let index = indexPath.row
            let icon = UIImage(named: langIcon[index])?.withRenderingMode(.alwaysTemplate)
            
            if (indexPath.row == 0) {
                headerCell.icon.image = icon
                headerCell.header.text = "Programming Languages"
                headerCell.label.text = lang[index]
                headerCell.width.constant = langScore[lang[index]]!
                return headerCell
            }
            skillCell.icon.image = icon
            skillCell.label.text = lang[index]
            skillCell.width.constant = langScore[lang[index]]!
            return skillCell
            
        } else if (indexPath.row < (areas.count + lang.count)) {
            let index = indexPath.row - lang.count
            let icon = UIImage(named: areasIcon[index])?.withRenderingMode(.alwaysTemplate)
            
            if ((indexPath.row - lang.count) == 0) {
                headerCell.header.text = "Knowledgeable Areas"
                headerCell.icon.image = icon
                headerCell.label.text = areas[index]
                headerCell.width.constant = areasScore[areas[index]]!
                return headerCell
            }
            skillCell.icon.image = icon
            skillCell.width.constant = three
            skillCell.label.text = areas[index]
            skillCell.width.constant = areasScore[areas[index]]!
            return skillCell
            
        } else {
            
            let index = indexPath.row - (lang.count + areas.count)
            let icon = UIImage(named: osIcon[index])?.withRenderingMode(.alwaysTemplate)
            
            if ((indexPath.row - (lang.count + areas.count)) == 0) {
                headerCell.header.text = "Operating Systems"
                headerCell.icon.image = icon
                headerCell.label.text = os[index]
                headerCell.width.constant = osScore[os[index]]!
                return headerCell
            }
            skillCell.icon.image = icon
            skillCell.width.constant = three
            skillCell.label.text = os[index]
            headerCell.width.constant = osScore[os[index]]!
            return skillCell
            
        }
        
    }
}
