//
//  IssueDetailsView.swift
//  Saturdays
//
//  Created by Said Ozcan on 05/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsView: UIViewController {
    
    //MARK: Properties
    public var imageViewFrame : CGRect {
        get {
            return self.imageView.frame
        }
        set {
            
        }
    }
    fileprivate let item : IssueViewModel
    fileprivate let presenter : IssueDetailsPresenter
    fileprivate let issueImage : UIImage?
    
    //MARK: Subviews
    fileprivate lazy var imageView : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = self.issueImage
        return imageView
    }()
    
    //MARK: Lifecycle
    override var prefersStatusBarHidden: Bool {
        if isViewLoaded {
            return true
        } else {
            return false
        }
    }
    
    init(with presenter:IssueDetailsPresenter, item:IssueViewModel, issueImage:UIImage?) {
        self.presenter = presenter
        self.item = item
        self.issueImage = issueImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item.title
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    //MARK: Private
    fileprivate func addSubviews() {
        guard let _ = self.issueImage else { return }
        self.view.addSubview(self.imageView)
    }
    
    fileprivate func setupLayoutConstraints() {
        guard let issueImage = self.issueImage else { return }
        NSLayoutConstraint.activate(***REMOVED***
            self.imageView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant:150),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: issueImage.size.height)
***REMOVED***)
    }
}
