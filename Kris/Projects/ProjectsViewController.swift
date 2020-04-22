//
//  ProjectsViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/28/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class ProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    fileprivate(set) var collectionView: UICollectionView

    let icons = ["AppStore", "Firefox", "Website", "Raft", "Server", "UDP", "VR", "Ray"]
    let proj = ["Exchange App", "Firefox Application Services", "Social Website", "Raft Consensus Algorithm", "HTTP Web Server", "UDP Ping-Pong", "VR Bowling", "Ray Tracer"]
    let lang = ["Swift, Node.js, Firebase, Google Cloud Firestore, Algolia, ﻿Stripe, Braintree", "Swift, Rust", "HTML/CSS, PHP, MySQL", "Go", "C", "C", "C#", "C#"]
    let desc = ["Developed and launched an iOS marketplace app that allows registered users to exchange items in-app", "Contributed to the Mozilla Foundation open source application via GitHub", "Built a Facebook style website using cPanel, phpMyAdmin, and MySQL", "Implemented the distributed consensus and replicated state machine layer of Raft", "Built a web server that communicates using the HTTP protocol over TCP/IP", "Built a client and server echo response/request program using UDP", "Built a Virtual Reality bowling game using Unity and Blender", "Built a basic Ray Tracer in Unity"]
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Projects"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let blocked = Blocked(target: self)
        blocked.isBlocked()
    }

    private func configureCollectionViewCells() {
        collectionView.register(ProjectsCell.self, forCellWithReuseIdentifier: ProjectsCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proj.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let projectCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCell.reuseId, for: indexPath) as! ProjectsCell
        
        let image = UIImage(named: icons[indexPath.row])?
            .withRenderingMode(.alwaysTemplate)
        projectCell.project.icon.image = image
        projectCell.project.header.text = proj[indexPath.row]
        projectCell.project.body.text = desc[indexPath.row]
        
        let text = "Languages & Tools: "
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.foregroundColor: ColorTheme.black
        ])
        
        let normalString = NSMutableAttributedString(string: lang[indexPath.row], attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
            NSAttributedString.Key.foregroundColor: ColorTheme.black
        ])
        
        attributedString.append(normalString)
        projectCell.languages.attributedText = attributedString
        
        return projectCell
    }

}
