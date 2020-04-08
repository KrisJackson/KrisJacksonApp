//
//  LinkView.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/2/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

class LinkView: UIView {
    var link: URL!
    
    let view: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.2
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = ColorTheme.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let border: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let preview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = ColorTheme.lightBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.linkViewGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = ColorTheme.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pageRoot: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorTheme.linkViewText
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(metadata: LinkMetadata) {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(preview)
        preview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        preview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(labelContainer)
        labelContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        labelContainer.centerXAnchor.constraint(equalTo: preview.centerXAnchor).isActive = true
        
        labelContainer.addSubview(pageTitle)
        pageTitle.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        pageTitle.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 12).isActive = true
        pageTitle.leftAnchor.constraint(equalTo: labelContainer.leftAnchor, constant: 15).isActive = true
        
        labelContainer.addSubview(pageRoot)
        pageRoot.leftAnchor.constraint(equalTo: pageTitle.leftAnchor).isActive = true
        pageRoot.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        pageRoot.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 0).isActive = true
        pageRoot.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: -12).isActive = true
        
        addSubview(button)
        bringSubviewToFront(button)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        link = LinkMetadata.stringToURL(string: metadata.urlPath)
        handleMeta(meta: metadata)
        
        preview.bottomAnchor.constraint(equalTo: labelContainer.topAnchor).isActive = true
        
        view.addSubview(border)
        border.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        border.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        border.topAnchor.constraint(equalTo: preview.bottomAnchor).isActive = true
        border.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handleMeta(meta: LinkMetadata) {
        if let ref = meta.imageRef {
            preview.sd_setImage(with: ref)
        }
        
        if let t = meta.title {
            pageTitle.text = t
        }
        
        if let r = meta.urlRoot {
            pageRoot.text = r
        }
        
        button.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
    }
    
    @objc private func goToLink() {
        if let link = link {
            let vc = SFSafariViewController(url: link)
            vc.preferredBarTintColor = ColorTheme.white
            vc.preferredControlTintColor = ColorTheme.blue
            vc.modalPresentationStyle = .automatic
            vc.dismissButtonStyle = .close
            window?.rootViewController?.present(vc, animated: true) // May not work
        }
    }
}

extension LinkView {
    class LinkMetadata: NSObject, NSDiscardableContent {
        
        var title: String!
        var urlRoot: String!
        var urlPath: String!
        var imageRef: StorageReference? = StorageReference()
    
        static func stringToURL(string: String?) -> URL? {
            if let string = string {
                return URL(string: string)
            }; return nil
        }
        
        static func stringToReference(string: String?) -> StorageReference? {
            if let string = string {
                return Storage.storage().reference(withPath: "link/\(string)")
            }; return nil
        }
        
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
}
