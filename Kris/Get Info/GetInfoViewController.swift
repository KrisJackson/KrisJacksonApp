//
//  GetInfoViewController.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/4/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase

class GetInfoViewController: UIViewController {
    
    var bottom: NSLayoutConstraint!
    let error = "Please enter your first and last name so I can address you appropriately."
    let message = "Before we get to chatting, I want to learn more about you. Please enter your information in the fields below."
    
    let header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "Let's Get To Know Each Other!"
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.text = message
        label.textColor = ColorTheme.jobText
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var close: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(ColorTheme.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = ColorTheme.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: false)
        return scrollView
    }()
    
    let firstTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.textColor = ColorTheme.black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = ColorTheme.textViewBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, -10);
        textField.attributedPlaceholder = NSAttributedString(
            string: "First",
            attributes: [NSAttributedString.Key.foregroundColor : ColorTheme.placeholder])
        return textField
    }()
    
    let lastTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.textColor = ColorTheme.black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = ColorTheme.textViewBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, -10);
        textField.attributedPlaceholder = NSAttributedString(
            string: "Last",
            attributes: [NSAttributedString.Key.foregroundColor : ColorTheme.placeholder])
        return textField
    }()
    
    let emailTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.textColor = ColorTheme.black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = ColorTheme.textViewBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, -10);
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email (Optional)",
            attributes: [NSAttributedString.Key.foregroundColor : ColorTheme.placeholder])
        return textField
    }()
    
    let companyTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.textColor = ColorTheme.black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = ColorTheme.textViewBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, -10);
        textField.attributedPlaceholder = NSAttributedString(
            string: "Company (Optional)",
            attributes: [NSAttributedString.Key.foregroundColor : ColorTheme.placeholder])
        return textField
    }()
    
    lazy var submit: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = ColorTheme.blue
        button.setTitleColor(ColorTheme.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(sendUser), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(close)
        close.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        close.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: close.bottomAnchor, constant: 15).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true

        scrollView.addSubview(header)
        header.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        header.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        header.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        header.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(subHeader)
        subHeader.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        subHeader.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        subHeader.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(firstTF)
        firstTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
        firstTF.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        firstTF.topAnchor.constraint(equalTo: subHeader.bottomAnchor, constant: 15).isActive = true
        
        scrollView.addSubview(lastTF)
        lastTF.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        lastTF.widthAnchor.constraint(equalTo: firstTF.widthAnchor).isActive = true
        lastTF.heightAnchor.constraint(equalTo: firstTF.heightAnchor).isActive = true
        lastTF.centerYAnchor.constraint(equalTo: firstTF.centerYAnchor).isActive = true
        lastTF.leftAnchor.constraint(equalTo: firstTF.rightAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(emailTF)
        emailTF.leftAnchor.constraint(equalTo: firstTF.leftAnchor).isActive = true
        emailTF.rightAnchor.constraint(equalTo: lastTF.rightAnchor).isActive = true
        emailTF.heightAnchor.constraint(equalTo: firstTF.heightAnchor).isActive = true
        emailTF.topAnchor.constraint(equalTo: firstTF.bottomAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(emailTF)
        emailTF.leftAnchor.constraint(equalTo: firstTF.leftAnchor).isActive = true
        emailTF.rightAnchor.constraint(equalTo: lastTF.rightAnchor).isActive = true
        emailTF.heightAnchor.constraint(equalTo: firstTF.heightAnchor).isActive = true
        emailTF.topAnchor.constraint(equalTo: firstTF.bottomAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(companyTF)
        companyTF.leftAnchor.constraint(equalTo: firstTF.leftAnchor).isActive = true
        companyTF.rightAnchor.constraint(equalTo: lastTF.rightAnchor).isActive = true
        companyTF.heightAnchor.constraint(equalTo: firstTF.heightAnchor).isActive = true
        companyTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(submit)
        submit.leftAnchor.constraint(equalTo: firstTF.leftAnchor).isActive = true
        submit.rightAnchor.constraint(equalTo: lastTF.rightAnchor).isActive = true
        submit.heightAnchor.constraint(equalTo: firstTF.heightAnchor).isActive = true
        submit.topAnchor.constraint(equalTo: companyTF.bottomAnchor, constant: 20).isActive = true
        submit.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(view.frame.height - 350)).isActive = true
        
        setupKeyboardObservers()
        dismissKeyboadOnBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isBlocked()
    }

    @objc private func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendUser() {
        
        let first = firstTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let last = lastTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var email: String? = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var company: String? = companyTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (first.isEmpty) || (last.isEmpty) {
            
            subHeader.text = error
            subHeader.textColor = ColorTheme.red
            
        } else {
            
            subHeader.text = message
            subHeader.textColor = ColorTheme.jobText
            
            if email!.isEmpty {
                email = nil
            }
            
            if company!.isEmpty {
                company = nil
            }
            
            Firestore.firestore().collection("devices")
                .document(UIDevice.current.identifierForVendor!.uuidString)
                .setData([
                    "email" : email ?? NSNull(),
                    "company" : company ?? NSNull(),
                    "first": first,
                    "last": last
                ], merge: true) { (error) in
                    if error == nil {
                    
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                    
                        self.subHeader.text = error!.localizedDescription
                        self.subHeader.textColor = ColorTheme.red
                    
                    }
            }
            
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
        scrollView.isScrollEnabled = true
    }
    

    @objc internal func handleKeyboardWillHide(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        let offset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func isBlocked() {
        Firestore.firestore().collection("devices").document(UIDevice.current.identifierForVendor!.uuidString).getDocument { (snapshot, error) in
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    if let isBlocked = snapshot.data()!["blocked"] as? Bool {
                        
                        if isBlocked {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "Blocked") as! BlockedViewController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false, completion: nil)
                        }
                        
                    }
                }
            }
        }
    }
}
