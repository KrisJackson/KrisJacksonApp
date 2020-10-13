//
//  WorkViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class WorkViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var num = 0
    let cache = NSCache<AnyObject, Jobs>()
    fileprivate(set) var collectionView: UICollectionView
    
    let project = UIImage(named: "Project")?.withRenderingMode(.alwaysTemplate)
    let skills = UIImage(named: "CV")?.withRenderingMode(.alwaysTemplate)
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logo: UILabel = {
        let label = UILabel()
        label.text = "Work & Experience"
        label.textAlignment = .center
        label.textColor = ColorTheme.white
        label.font = .systemFont(ofSize: 22, weight: .bold)
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJobs()
        configureHeaderAndLogo()
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
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
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
        collectionView.register(WorkHeaderCell.self, forCellWithReuseIdentifier: WorkHeaderCell.reuseId)
        collectionView.register(JobCell.self, forCellWithReuseIdentifier: JobCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num +  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkHeaderCell.reuseId, for: indexPath) as! WorkHeaderCell
        let jobCell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCell.reuseId, for: indexPath) as! JobCell
        
        
        if indexPath.row == 0 {
            headerCell.skillsTapped.addTarget(self, action: #selector(goToSkills))
            headerCell.projectTapped.addTarget(self, action: #selector(goToProjects))
            return headerCell
        }
        
        if let job: Jobs = cache.object(forKey: indexPath.row - 1 as AnyObject) {
            if let backgroundImg = job.background_img {
                let ref = Storage.storage().reference(withPath: "job_background/\(backgroundImg)")
                jobCell.backgroundImage.sd_setImage(with: ref)
            }
            
            if let mainImg = job.main_img {
                let ref = Storage.storage().reference(withPath: "job_profile/\(mainImg)")
                jobCell.profileImage.sd_setImage(with: ref)
            }
            
            if let company = job.company {
                jobCell.company.text = company
            }
            
            if let city = job.city {
                if let state = job.state {
                    jobCell.location.text = "\(city), \(state)"
                }
            }
            
            if let job = job.job {
                jobCell.job.header.text = job
            }
            
            if let desc = job.desc {
                jobCell.job.body.text = desc
            }
            
            if let tools = job.tools {
                jobCell.tools.body.text = tools
            }
            
            if let duration = job.duration {
                jobCell.duration.body.text = duration
            }
        }
        return jobCell
    }
    
    private func configureHeaderAndLogo() {
        // Configs headerview
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // Adds logo to header view
        headerView.addSubview(logo)
        logo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logo.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        logo.topAnchor.constraint(equalTo: headerView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
    }

    private func getJobs() {
        Firestore.firestore().collection("jobs")
            .order(by: "priority", descending: false)
            .addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    for (i, document) in snapshot.documents.enumerated() {
                            let job = Jobs()
                            job.main_img = document.data()["main_img"] as? String
                            job.background_img = document.data()["background_img"] as? String
                            job.company = document.data()["company"] as? String
                            job.job = document.data()["title"] as? String
                            job.desc = document.data()["desc"] as? String
                            job.duration = document.data()["duration"] as? String
                            job.city = document.data()["city"] as? String
                            job.state = document.data()["state"] as? String
                            job.type = document.data()["type"] as? String
                            job.tools = document.data()["tools"] as? String
                            self.cache.setObject(job, forKey: i as AnyObject)
                    }
                    self.num = snapshot.count
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc private func goToSkills() {
        performSegue(withIdentifier: "goToSkills", sender: self)
    }
    
    @objc private func goToProjects() {
        performSegue(withIdentifier: "goToProjects", sender: self)
    }
}

class Jobs: NSObject, NSDiscardableContent {
    var company: String!
    var desc: String!
    var job: String!
    var type: String!
    var duration: String!
    var background_img: String!
    var city: String!
    var state: String!
    var state_abr: String!
    var main_img: String!
    var tools: String!

    func beginContentAccess() -> Bool {
        return true
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
    
    func endContentAccess() {
    }
    
    func discardContentIfPossible() {
    }
}
