//
//  InboxVC.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/11/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class InboxVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var num = 0
    let cache = NSCache<AnyObject, Inbox>()
    
    fileprivate(set) var collectionView: UICollectionView
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Inbox"
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
        getChannels()
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
        collectionView.register(InboxCell.self, forCellWithReuseIdentifier: InboxCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InboxCell.reuseId, for: indexPath) as! InboxCell
        guard let inbox = cache.object(forKey: indexPath.row as AnyObject) else { return cell }
        getData(id: inbox.userID) { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                let first = (snapshot.data()!["first"] as? String) ?? "NULL"
                let last = (snapshot.data()!["last"] as? String) ?? "NULL"
                cell.name.text = "\(first) \(last)"
            }
        }
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: inbox.timestamp)!)
        let elapsed = date.getElapsedInterval()
        cell.date.text = elapsed
        cell.message.text = inbox.lastMessage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let inbox = cache.object(forKey: indexPath.row as AnyObject) else { return }
        getData(id: inbox.userID) { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                let first = (snapshot.data()!["first"] as? String) ?? "{NULL}"
                let last = (snapshot.data()!["last"] as? String) ?? "{NULL}"
                let token = (snapshot.data()!["token"] as? String) ?? ""
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
                vc.modalPresentationStyle = .fullScreen
                vc.token = token
                vc.fromOwner = true
                vc.forUser = inbox.userID
                vc.fullName = "\(first) \(last)"
                vc.channelID = snapshot.documentID
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func getChannels() {
        Firestore.firestore().collection("channels").order(by: "timestamp", descending: true)
            .addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                for (i, document) in snapshot.documents.enumerated() {
                    DispatchQueue.main.async {
                        let inbox = Inbox()
                        inbox.userID = document.documentID
                        inbox.timestamp = document.data()["timestamp"] as? Int
                        inbox.fromOwner = document.data()["fromOwner"] as? Bool
                        inbox.lastMessage = document.data()["lastMessage"] as? String
                        self.cache.setObject(inbox, forKey: i as AnyObject)
                    }
                }
                self.num = snapshot.count
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        }
    }

    private func getData(id: String, _ completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        Firestore.firestore().collection("devices").document(id)
            .addSnapshotListener { (snapshot, error) in
                completion(snapshot, error)
        }
    }
}

class Inbox: NSObject, NSDiscardableContent {
    
    var timestamp: Int!
    var userID: String!
    var fromOwner: Bool!
    var lastMessage: String!
    
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
