//
//  IssueDetailsPostCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostCell: UITableViewCell {
    
    //MARK: Properties
    lazy var postImageView : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    fileprivate lazy var postImageViewHeightConstraint : NSLayoutConstraint = { ***REMOVED***unowned self***REMOVED*** in
        return self.postImageView.heightAnchor.constraint(equalToConstant: 0.0)
    }()
    
    //MARK: Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postImageView.image = nil
    }
    
    //MARK: Public
    func configure(with post:PostViewModel) {
        guard let photoSize = post.photoSize else { return }
        self.postImageViewHeightConstraint.constant = photoSize.appropriateSize(for: self.contentView.frame.size).height
    }
    
    //MARK: Private
    fileprivate func setupLayout() {
        let bottomAnchor : NSLayoutConstraint = self.postImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        bottomAnchor.priority = UILayoutPriorityDefaultHigh - 1
        
        self.contentView.addSubview(self.postImageView)
        NSLayoutConstraint.activate(***REMOVED***
            self.postImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            bottomAnchor,
            self.postImageViewHeightConstraint
***REMOVED***)
    }
}


