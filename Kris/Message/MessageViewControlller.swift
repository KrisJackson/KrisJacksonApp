//
//  MessageViewControlller.swift
//  Kris
//
//  Created by Kristopher Jackson on 3/21/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var fullName = "Kris"
    var fromOwner = false
    var forUser: String!
    var isPlaceholder = true
    var token = KRIS_TOKEN
    var channelID = UIDevice.current.identifierForVendor!.uuidString
    var containerViewBottom: NSLayoutConstraint?
    
    var num = Int()
    let cache = NSCache<AnyObject, Message>()
    fileprivate(set) var collectionView: UICollectionView
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logo: UILabel = {
        let label = UILabel()
        label.text = fullName
        label.textAlignment = .center
        label.textColor = ColorTheme.white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Tabbar shadow
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowColor = #colorLiteral(red: 0.003921568627, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
    lazy var cancel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(ColorTheme.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
//        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        return button
    }()
    
    let textContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = ColorTheme.textViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.text = "Start a message"
        textView.textColor = ColorTheme.placeholder
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var send: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = ColorTheme.blue
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
        configureHeaderAndLogo()
        configureCollectionView()
        configureTextField()
        setupKeyboardObservers()
        dismissKeyboadOnBackgroundTap()
        configureCollectionViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let tabbarController = tabBarController as? TabBarViewController {
            tabbarController.tabBar.layer.shadowColor = UIColor.clear.cgColor
            tabbarController.inbox.isHidden = true
        }
        let blocked = Blocked(target: self)
        blocked.isBlocked()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let tabbarController = tabBarController as? TabBarViewController {
            tabbarController.tabBar.layer.shadowColor = ColorTheme.tabBarShadowColor.cgColor
            tabbarController.inbox.isHidden = false
        }
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
        
        headerView.addSubview(cancel)
        cancel.centerYAnchor.constraint(equalTo: logo.centerYAnchor).isActive = true
        cancel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 12).isActive = true
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        view.sendSubviewToBack(collectionView)
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
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
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseId)
        collectionView.register(MessageHeaderCell.self, forCellWithReuseIdentifier: MessageHeaderCell.reuseId)
    }
    
    private func configureTextField() {
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        containerView.addSubview(textContainer)
        textContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        textContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        textContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        containerViewBottom = textContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        containerViewBottom!.isActive = true
        
        textContainer.addSubview(textView)
        textView.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 2).isActive = true
        textView.leftAnchor.constraint(equalTo: textContainer.leftAnchor, constant: 15).isActive = true
        textView.rightAnchor.constraint(equalTo: textContainer.rightAnchor, constant: -15).isActive = true
        textView.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: -2).isActive = true
        
        containerView.addSubview(send)
        send.heightAnchor.constraint(equalToConstant: 40).isActive = true
        send.widthAnchor.constraint(equalTo: send.heightAnchor).isActive = true
        send.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor).isActive = true
        send.leftAnchor.constraint(equalTo: textContainer.rightAnchor, constant: 5).isActive = true
        send.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 6000)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let header = collectionView.dequeueReusableCell(withReuseIdentifier: MessageHeaderCell.reuseId, for: indexPath) as! MessageHeaderCell
        let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseId, for: indexPath) as! MessageCell
        
        if (indexPath.row == 0) {
            return header
        } else {
            
            if let message: Message = cache.object(forKey: indexPath.row - 1 as AnyObject) {
                if let text = message.text {
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 2
                    messageCell.messageTextView.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
                    
                }
                
                if !fromOwner {
                    if let fromOwner = message.fromOwner {
                        if fromOwner {
                            
                            messageCell.nameLabel.text = "Kris Jackson"
                            messageCell.nameLabel.textColor = ColorTheme.blue
                            messageCell.highlightView.backgroundColor = ColorTheme.blue
                            
                        } else {
                            
                            messageCell.nameLabel.text = "Me"
                            messageCell.nameLabel.textColor = ColorTheme.purple
                            messageCell.highlightView.backgroundColor =  ColorTheme.purple
                            
                        }
                    }
                } else {
                    if let fromOwner = message.fromOwner {
                        if fromOwner {
                            
                            messageCell.nameLabel.text = "Me"
                            messageCell.nameLabel.textColor = ColorTheme.blue
                            messageCell.highlightView.backgroundColor = ColorTheme.blue
                            
                        } else {
                            
                            messageCell.nameLabel.text = fullName
                            messageCell.nameLabel.textColor = ColorTheme.purple
                            messageCell.highlightView.backgroundColor =  ColorTheme.purple
                            
                        }
                    }
                }
                
                
                if let timestamp = message.timestamp {
                    let date = Date(timeIntervalSince1970: TimeInterval(exactly: timestamp)!)
                    let elapsed = date.getElapsedInterval()
                    messageCell.dateLabel.text = elapsed
                }
            }
            
            return messageCell
            
        }
    }
    
    internal func dismissKeyboadOnBackgroundTap() {
        let dismissKeyboard = UITapGestureRecognizer()
        dismissKeyboard.addTarget(self, action: #selector(DismissKeyboard))
        super.view.addGestureRecognizer(dismissKeyboard)
    }
        
    internal func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc internal func DismissKeyboard() {
        super.view.endEditing(true)
    }
    
    
    @objc internal func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        containerViewBottom?.constant = -keyboardFrame!.height + view.safeAreaInsets.bottom - 10
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: self.num, section: 0), at: .bottom, animated: true)
            }
        }
    }
    

    @objc internal func handleKeyboardWillHide(notification: NSNotification) {
        guard let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        UIView.animate(withDuration: keyboardDuration) {
            self.containerViewBottom?.constant = -10
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ColorTheme.placeholder {
            isPlaceholder = false
            textView.text = nil
            textView.textColor = ColorTheme.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            isPlaceholder = true
            textView.text = "Start a message"
            textView.textColor = ColorTheme.placeholder
        }
    }
    
    @objc private func sendPressed() {
        if (isPlaceholder || textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) { return }
        doesUserExist { (exists, error) in
            if exists {
                let text = self.textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
                self.textView.text = nil
                
                self.sendMessage(text: text) { (error) in
                    if error != nil { return }
                    self.updateChannel(text: text) { (channelError) in
                        if channelError != nil { return }
                    }
                    
                    let item = self.num
                    let lastItemIndex = NSIndexPath(item: item, section: 0)
                    self.collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: true)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "getInfo", sender: self)
                }
                
            }
        }
    }
    
    private func doesUserExist(_ completion: @escaping (Bool, Error?) -> ()) {
        Firestore.firestore().collection("devices")
            .document(UIDevice.current.identifierForVendor!.uuidString)
            .getDocument { (snapshot, error) in
                if let snapshot = snapshot {
                    if let _ = snapshot.data()!["first"] as? String {
                        DispatchQueue.main.async { completion(true, error) }
                    } else {
                        DispatchQueue.main.async { completion(false, error) }
                    }
                } else {
                    DispatchQueue.main.async { completion(false, error) }
                }
        }
    }
    
    
    private func sendMessage(text: String, _ completion: @escaping (Error?) -> ()) {
        Firestore.firestore().collection("messages").document().setData([
            "text": text,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "fromOwner": fromOwner,
            "userID": channelID,
        ], merge: true) { (error) in
            DispatchQueue.main.async { completion(error) }
            self.sendPushNotification(text: text)
        }
    }
    
    private func sendPushNotification(text: String) {
        Firestore.firestore().collection("devices")
            .document(UIDevice.current.identifierForVendor!.uuidString)
            .getDocument { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                guard let first = snapshot.data()!["first"] as? String else { return }
                guard let last = snapshot.data()!["last"] as? String else { return }
                
                // Send push notification to receiver
                PushNotificationSender.sendPushNotification(toToken: self.token, title: "\(first) \(last)", body: text)
        }
    }
    
    private func updateChannel(text: String, _ completion: @escaping (Error?) -> ()) {
        Firestore.firestore().collection("channels")
            .document(channelID).setData([
                "lastMessage": text,
                "timestamp": Int(NSDate().timeIntervalSince1970),
                "fromOwner": false
        ], merge: true) { (error) in
            DispatchQueue.main.async { completion(error) }
        }
    }
    
    private func getMessages() {
        var userID = UIDevice.current.identifierForVendor!.uuidString
        if let uid = forUser { userID = uid }

        Firestore.firestore().collection("messages")
            .whereField("userID", isEqualTo: userID)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                for (i, document) in snapshot.documents.enumerated() {
                    DispatchQueue.main.async {
                        let message = Message()
                        message.text = document.data()["text"] as? String
                        message.timestamp = document.data()["timestamp"] as? Int
                        message.fromOwner = document.data()["fromOwner"] as? Bool
                        self.cache.setObject(message, forKey: i as AnyObject)
                    }
                }
                DispatchQueue.main.async {
                    self.num = snapshot.count
                    self.collectionView.reloadData()
                }
                
                let item = self.num
                let lastItemIndex = NSIndexPath(item: item, section: 0)
                self.collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @objc private func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension Date {

    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())

        if let year = interval.year, year > 0 {
            
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
            
        } else if let month = interval.month, month > 0 {
            
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
            
        } else if let day = interval.day, day > 0 {
            
            return day == 1 ? /* "\(day)" + " " + "day ago" */ "Yesterday" :
                "\(day)" + " " + "days ago"
            
        } else if let hour = interval.hour, hour > 0 {
            
                return hour == 1 ? "\(hour)" + " " + "hour ago" :
                    "\(hour)" + " " + "hours ago"
            
        } else if let minute = interval.minute, minute > 0 {
            
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
            
        } else if let second = interval.second, second > 0 {
            
            return "Just now"
//            return second == 1 ? "\(second)" + " " + "second ago" :
//                "a few seconds ago"
            
        } else {
            
            return "Just now"
            
        }

    }
}


class Message: NSObject, NSDiscardableContent {
    var text: String!
    var fromOwner: Bool!
    var timestamp: Int!
    var images: [String]!

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
