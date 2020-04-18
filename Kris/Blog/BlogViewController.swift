//
//  BlogViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import LinkPresentation

class BlogViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate(set) var collectionView: UICollectionView
    
    var postNum = 0
    let cache: NSCache = NSCache<AnyObject, Post>()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logo: UILabel = {
        let label = UILabel()
        label.text = "Blog"
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
        getData()
        configureHeaderAndLogo()
        configureCollectionView()
        configureCollectionViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let blocked = Blocked(target: self)
        blocked.isBlocked()
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
        logo.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        logo.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        logo.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        logo.topAnchor.constraint(equalTo: headerView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .vertical
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width = view.frame.width
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func configureCollectionViewCells() {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseId)
        collectionView.register(BlogCell.self, forCellWithReuseIdentifier: BlogCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseId, for: indexPath) as! PostCell
        let blog = collectionView.dequeueReusableCell(withReuseIdentifier: BlogCell.reuseId, for: indexPath) as! BlogCell
        
        if let post: Post = cache.object(forKey: indexPath.row as AnyObject) {
            if let _ = post.title {
                
                if let title = post.title {
                    blog.titleLabel.text = title
                }
                
                if let text = post.text {
                    let text = text.replacingOccurrences(of: "\\n", with: "\n")
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.hyphenationFactor = 1.0
                    paragraphStyle.lineSpacing = 3
                    let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
                    blog.text.attributedText = attributedString
                    blog.text.textAlignment = .natural
                    blog.text.textColor = #colorLiteral(red: 0.1607687175, green: 0.1607931256, blue: 0.1607603431, alpha: 1)
                }
                
                if let timestamp = post.timestamp {
                    blog.date.text = "Posted: \(Timestamp.unixToDateTime(unix: NSNumber(integerLiteral: timestamp), timeStyle: .short, dateStyle: .long))"
                }
                
                if let _ = post.link {
                    
                    blog.addLink()
                    DispatchQueue.main.async {
                        let linkView = LinkView(metadata: post.meta)
                        linkView.translatesAutoresizingMaskIntoConstraints = false
                        blog.linkView.addSubview(linkView)
                        linkView.topAnchor.constraint(equalTo: blog.linkView.topAnchor, constant: 0).isActive = true
                        linkView.leftAnchor.constraint(equalTo: blog.linkView.leftAnchor, constant: 0).isActive = true
                        linkView.rightAnchor.constraint(equalTo: blog.linkView.rightAnchor, constant: 0).isActive = true
                        linkView.bottomAnchor.constraint(equalTo: blog.linkView.bottomAnchor, constant: 0).isActive = true
                    }
                    
                } else {
                    
                    blog.removeLink()
                    
                }
                
                return blog
                
            } else {
                
                return postCell
                
            }
        }
        
        return blog
    }
    
    private func getData() {
        Firestore.firestore().collection("blog")
        .order(by: "timestamp", descending: true).addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                for (i, document) in snapshot.documents.enumerated() {
                    DispatchQueue.main.async {
                        let post = Post()
                        post.text = document.data()["text"] as? String
                        post.title = document.data()["title"] as? String
                        post.timestamp = document.data()["timestamp"] as? Int
                        post.images = document.data()["images"] as? [String]
                        if let urlString: String = document.data()["link"] as? String {
                            if let url: URL = URL(string: urlString) {
                                post.link = url
                                post.metadata.originalURL = url
                                post.metadata.url = url
                                post.metadata.title = document.data()["linkTitle"] as? String
                                
                                post.meta.imageRef = LinkView.LinkMetadata.stringToReference(string: document.data()["linkImage"] as? String)
                                post.meta.title = document.data()["linkTitle"] as? String
                                post.meta.urlPath = document.data()["link"] as? String
                                post.meta.urlRoot = document.data()["linkShort"] as? String
                                
                                
                            }
                        }
                        self.cache.setObject(post, forKey: i as AnyObject)
                    }
                }
                DispatchQueue.main.async {
                    self.postNum = snapshot.count
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

class Post: NSObject, NSDiscardableContent {
    var link: URL!
    var text: String!
    var timestamp: Int!
    var title: String!
    var images: [String]!
    var metadata: LPLinkMetadata = LPLinkMetadata()
    var meta: LinkView.LinkMetadata = LinkView.LinkMetadata()

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
