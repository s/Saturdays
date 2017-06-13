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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = UIDefines.Sizes.issueListCellCornerRadius
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var dismissIcon : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(image: Images.dismissIcon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    fileprivate lazy var issueTitleLabel : UILabel = { ***REMOVED***unowned self***REMOVED*** in
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.item.detailTitle
        label.font = UIDefines.Fonts.navigationBarLargeTitleViewTitle
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        return label
    }()
    
    fileprivate lazy var issueDescriptionLabel : UILabel = { ***REMOVED***unowned self***REMOVED*** in
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.item.detailDescription
        label.font = UIDefines.Fonts.body
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var scrollView : UIScrollView = { ***REMOVED***unowned self***REMOVED*** in
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIDefines.Colors.white
        scrollView.addSubview(self.allStackView)
        scrollView.addConstraints(***REMOVED***
            self.allStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.allStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.allStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.allStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.allStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
***REMOVED***)
        return scrollView
    }()
    
    fileprivate lazy var allStackView : UIStackView = { ***REMOVED***unowned self***REMOVED*** in
        let stackView = UIStackView(arrangedSubviews: ***REMOVED***
            self.headerStackView,
            self.imageView,
            self.tracksView.view
***REMOVED***)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.spacing = UIDefines.Spacings.cellSpacing
        stackView.alignment = .fill
        
        self.addChildViewController(self.tracksView)
        self.tracksView.didMove(toParentViewController:self)
        
        return stackView
    }()
    
    fileprivate lazy var headerStackView : UIStackView = { ***REMOVED***unowned self***REMOVED*** in
        let stackView = UIStackView(arrangedSubviews: ***REMOVED***
            self.issueTitleLabel,
            self.issueDescriptionLabel
***REMOVED***)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.spacing = UIDefines.Spacings.singleUnit
        stackView.alignment = .fill
        
        return stackView
    }()
    
    fileprivate lazy var tracksView : IssueDetailsTrackView = { ***REMOVED***unowned self***REMOVED*** in
        let trackView = IssueDetailsTrackView(with: self.item.tracks)
        trackView.view.translatesAutoresizingMaskIntoConstraints = false
        return trackView
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
        
        self.view.backgroundColor = UIDefines.Colors.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.addSubviews()
        self.setupLayoutConstraints()
        self.setupDismissIcon()
    }
    
    
    //MARK: Private
    fileprivate func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.dismissIcon)
        self.view.sendSubview(toBack: self.scrollView)
    }
    
    fileprivate func setupLayoutConstraints() {
        NSLayoutConstraint.activate(***REMOVED***
            self.dismissIcon.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.dismissIcon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit),
            self.dismissIcon.widthAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsDismissIconDimension),
            self.dismissIcon.heightAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsDismissIconDimension),
            
            self.scrollView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-UIDefines.Spacings.doubleUnit),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit),
***REMOVED***)
    }
    
    fileprivate func setupDismissIcon() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissIssue))
        self.dismissIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func dismissIssue() {
        self.dismiss(animated: true, completion: nil)
    }
}
