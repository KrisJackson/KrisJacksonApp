//
//  InterestsViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import SafariServices
import LinkPresentation
import SDWebImageLinkPlugin

class InterestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bookNum = 0
    var albumNum = 0
    let books = NSCache<AnyObject, Book>()
    let albums = NSCache<AnyObject, Album>()
    let blogs = NSCache<AnyObject, Link>()
    let videos = NSCache<AnyObject, Link>()
    
    let blogsString = [
        "https://ai.googleblog.com/2019/10/quantum-supremacy-using-programmable.html",
        "https://blog.google/technology/health/improving-breast-cancer-screening/",
        "https://blogs.microsoft.com/blog/2020/01/16/microsoft-will-be-carbon-negative-by-2030/",
        "https://www.ibm.com/blogs/research/2020/01/huntingtons-disease-research-using-ai/",
        "https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/",
        "https://ai.googleblog.com/2019/10/learning-to-smell-using-deep-learning.html"]
    
    fileprivate(set) var collectionView: UICollectionView
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
//        // View shadow
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
        
        return view
    }()
    
    let logo: UILabel = {
        let label = UILabel()
        label.text = "Interests"
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
        getBooks()
        getAlbums()
        getBlogs()
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
    
    private func configureCollectionViewCells() {
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.reuseId)
        collectionView.register(FavHeaderCell.self, forCellWithReuseIdentifier: FavHeaderCell.reuseId)
        collectionView.register(LinkCell.self, forCellWithReuseIdentifier: LinkCell.reuseId)
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.reuseId)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookNum + albumNum + blogsString.count + 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavHeaderCell.reuseId, for: indexPath) as! FavHeaderCell
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.reuseId, for: indexPath) as! BookCell
        let linkCell = collectionView.dequeueReusableCell(withReuseIdentifier: LinkCell.reuseId, for: indexPath) as! LinkCell
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.reuseId, for: indexPath) as! AlbumCell
        
        if indexPath.row == 0 {
            let book = UIImage(named: "Books")?.withRenderingMode(.alwaysTemplate)
            headerCell.header.text = "Books"
            headerCell.iconImage.image = book
            return headerCell
        }
        
        if let book: Book = books.object(forKey: indexPath.row - 1 as AnyObject) {
            if let cover = book.cover {
                let ref = Storage.storage().reference(withPath: "fav/\(cover)")
                bookCell.image.sd_setImage(with: ref)
            }
            
            if let title = book.title {
                bookCell.header.text = title
            }
            
            if let sub = book.subHeader {
                bookCell.subHeader.text = sub
                bookCell.subHeaderAdded()
            } else {
                bookCell.descAdded()
            }
            
            if let author = book.author {
                bookCell.desc.text = author
            }
            
            bookCell.moreButton.tag = indexPath.row - 1
            bookCell.moreButton.addTarget(self, action: #selector(goToGoodReads(sender:)), for: .touchUpInside)
            return bookCell
        }
        
        if indexPath.row == (bookNum + 1) {
             let music = UIImage(named: "Music")?.withRenderingMode(.alwaysTemplate)
             headerCell.header.text = "Albums"
             headerCell.iconImage.image = music
             return headerCell
         }

         if let album: Album = albums.object(forKey: (indexPath.row - (2 + bookNum)) as AnyObject) {
             if let cover = album.cover {
                 let ref = Storage.storage().reference(withPath: "fav/\(cover)")
                 albumCell.image.sd_setImage(with: ref)
             }

             if let title = album.title {
                 albumCell.header.text = title
             }

             if let artist = album.artist {
                 albumCell.subHeader.text = artist
            }

             if let genre = album.genre {
                 albumCell.desc.text = genre
             }

             albumCell.moreButton.tag = (indexPath.row - (2 + bookNum))
             albumCell.moreButton.addTarget(self, action: #selector(goToSpotify(sender:)), for: .touchUpInside)
             return albumCell
         }
        
        if (indexPath.row == (bookNum + albumNum + 2)) {
            let book = UIImage(named: "Blog")?.withRenderingMode(.alwaysTemplate)
            headerCell.header.text = "Interesting Articles"
            headerCell.iconImage.image = book
            return headerCell
        }
        
        if let link: Link = blogs.object(forKey: indexPath.row - (3 + bookNum + albumNum) as AnyObject) {
            let linkview = LinkView(metadata: link.meta)
            DispatchQueue.main.async {
                linkview.translatesAutoresizingMaskIntoConstraints = false
                for view in linkCell.backView.subviews {view.removeFromSuperview()}
                linkCell.backView.addSubview(linkview)
                linkview.topAnchor.constraint(equalTo: linkCell.backView.topAnchor, constant: 12).isActive = true
                linkview.leftAnchor.constraint(equalTo: linkCell.backView.leftAnchor, constant: 12).isActive = true
                linkview.rightAnchor.constraint(equalTo: linkCell.backView.rightAnchor, constant: -12).isActive = true
                linkview.bottomAnchor.constraint(equalTo: linkCell.backView.bottomAnchor, constant: -12).isActive = true
            }
            return linkCell
            
        }
        
        return linkCell
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
    
    private func getBooks() {
        Firestore.firestore().collection("interests")
            .whereField("type", isEqualTo: "book").order(by: "title")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    for (i, document) in snapshot.documents.enumerated() {
                        
                        let book = Book()
                        book.author = document.data()["author"] as? String
                        book.title = document.data()["title"] as? String
                        book.cover = document.data()["cover"] as? String
                        book.subHeader = document.data()["sub"] as? String
                        book.link = document.data()["link"] as? String
                        self.books.setObject(book, forKey: i as AnyObject)
                        
                    }
                    
                    self.bookNum = snapshot.count
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
        }
    }
    
    private func getAlbums() {
        Firestore.firestore().collection("interests")
            .whereField("type", isEqualTo: "album").order(by: "title")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    for (i, document) in snapshot.documents.enumerated() {
                        
                        let album = Album()
                        album.artist = document.data()["artist"] as? String
                        album.title = document.data()["title"] as? String
                        album.cover = document.data()["cover"] as? String
                        album.genre = document.data()["genre"] as? String
                        album.link = document.data()["link"] as? String
                        self.albums.setObject(album, forKey: i as AnyObject)
                        
                    }
                    
                    self.albumNum = snapshot.count
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
        }
    }
    
    private func getBlogs() {
        Firestore.firestore().collection("interests")
            .whereField("type", isEqualTo: "blog").order(by: "priority")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    for (i, document) in snapshot.documents.enumerated() {
                        let link = Link()
                        link.image = document.data()["image"] as? String
                        link.title = document.data()["title"] as? String
                        link.shortLink = document.data()["shortLink"] as? String
                        link.link = document.data()["link"] as? String
                        
                        link.meta.imageRef = LinkView.LinkMetadata.stringToReference(string: document.data()["image"] as? String)
                        link.meta.title = document.data()["title"] as? String
                        link.meta.urlPath = document.data()["link"] as? String
                        link.meta.urlRoot = document.data()["shortLink"] as? String
                        self.blogs.setObject(link, forKey: i as AnyObject)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
        }
    }
    
    private func getMetadata(url: URL, _ completion: @escaping(LPLinkMetadata?, Error?) -> Void) {
        let metaDataProvider = LPMetadataProvider()
        metaDataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            completion(metadata, error)
        }
    }
    
    @objc private func goToGoodReads(sender: UIButton) {
        if let book: Book = books.object(forKey: sender.tag as AnyObject) {
            if let urlString: String = book.link {
                if let url = URL(string: urlString) {
                    let vc = SFSafariViewController(url: url)
                    vc.preferredBarTintColor = ColorTheme.white
                    vc.preferredControlTintColor = ColorTheme.blue
                    vc.modalPresentationStyle = .automatic
                    vc.dismissButtonStyle = .close
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
    @objc private func goToSpotify(sender: UIButton) {
        if let album: Album = albums.object(forKey: sender.tag as AnyObject) {
            if let urlString: String = album.link {
                if let url = URL(string: urlString) {
                    let vc = SFSafariViewController(url: url)
                    vc.preferredBarTintColor = ColorTheme.white
                    vc.preferredControlTintColor = ColorTheme.blue
                    vc.modalPresentationStyle = .automatic
                    vc.dismissButtonStyle = .close
                    self.present(vc, animated: true)
                }
            }
        }
    }
}

class Book: NSObject, NSDiscardableContent {
    var title: String!
    var cover: String!
    var subHeader: String!
    var author: String!
    var link: String!

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

class Album: NSObject, NSDiscardableContent {
    var title: String!
    var cover: String!
    var artist: String!
    var genre: String!
    var link: String!

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

class Link: NSObject, NSDiscardableContent {
    var metadata: LPLinkMetadata!
    var shortLink: String!
    var link: String!
    var title: String!
    var remoteLink: String!
    var image: String!
    var iName: String!
    var iType: String!
    var meta: LinkView.LinkMetadata! = LinkView.LinkMetadata()

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
