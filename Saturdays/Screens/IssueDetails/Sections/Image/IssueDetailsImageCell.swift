//
//  IssueDetailsImageView.swift
//  Saturdays
//
//  Created by Said Ozcan on 14/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsImageCell: UITableViewCell {
    
    //MARK: Properties
    
    fileprivate lazy var issueImageView : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    //MARK: Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func configure(with image:UIImage) {
        self.issueImageView.image = image
    }
    
    //MARK: Private
    fileprivate func setupLayout() {
        self.contentView.addSubview(self.issueImageView)
        NSLayoutConstraint.activate(***REMOVED***
            self.issueImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.issueImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.issueImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.issueImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
***REMOVED***)
    }
}

