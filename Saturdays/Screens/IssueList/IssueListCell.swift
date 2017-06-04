//
//  IssueListCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 03/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Shimmer

class IssueListCell: UITableViewCell {
    
    //MARK : Subviews
    let issueImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIDefines.Colors.lightGrayColor
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var issueTitleView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        let titleView = UIView(frame: CGRect.zero)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = UIColor.black
        
        titleView.addSubview(self.issueTitleLabel)
        NSLayoutConstraint.activate(***REMOVED***
            self.issueTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor,
                                                     constant:UIDefines.Spacings.singleUnit.rawValue),
            self.issueTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor,
                                                         constant: UIDefines.Spacings.singleUnit.rawValue),
            self.issueTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor,
                                                         constant: -UIDefines.Spacings.singleUnit.rawValue),
            self.issueTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor,
                                                           constant: -UIDefines.Spacings.singleUnit.rawValue)
***REMOVED***)
        
        titleView.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        return titleView
    }()
    
    fileprivate let issueTitleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIDefines.Fonts.bodyFont
        label.textColor = UIDefines.Colors.whiteColor
        return label
    }()
    
    
    // MARK : Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.layer.masksToBounds = true
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.issueImageView.image = nil
        self.issueTitleLabel.text = nil
    }
    
    // MARK : Private
    fileprivate func addSubviews() {
        self.contentView.addSubview(self.issueImageView)
        self.contentView.addSubview(self.issueTitleView)
    }
    
    fileprivate func setupLayoutConstraints() {
        let spacing = UIDefines.Spacings.doubleUnit.rawValue
        
        let trailingConstraintOfTitleView = self.issueTitleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                                                          constant: -spacing)
        trailingConstraintOfTitleView.priority = UILayoutPriorityDefaultLow - 1
        NSLayoutConstraint.activate(***REMOVED***
            self.issueImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.issueImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.issueImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.issueImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.issueTitleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                         constant: spacing),
            self.issueTitleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                        constant: -spacing),
            trailingConstraintOfTitleView
***REMOVED***)
    }
    
    // MARK : Public Interface
    func configure(with model: IssueViewModel) {
        self.issueTitleLabel.text = model.title
    }
}

