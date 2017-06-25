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
        imageView.backgroundColor = Defines.Colors.lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Defines.Sizes.issueListCellCornerRadius
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var issueTitleView : UIView = { [unowned self] in
        let titleView = UIView(frame: CGRect.zero)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = UIColor.black
        titleView.layer.cornerRadius = Defines.Sizes.issueListCellCornerRadius
        titleView.layer.masksToBounds = true
        
        titleView.addSubview(self.issueTitleLabel)
        NSLayoutConstraint.activate([
            self.issueTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant:Defines.Spacings.singleUnit),
            self.issueTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: Defines.Spacings.singleUnit),
            self.issueTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -Defines.Spacings.singleUnit),
            self.issueTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -Defines.Spacings.singleUnit)
        ])
        
        titleView.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        return titleView
    }()
    
    fileprivate let issueTitleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Defines.Fonts.body
        label.textColor = Defines.Colors.white
        return label
    }()
    
    
    //MARK: Properties
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.width = frame.width - (2 * Defines.Spacings.doubleUnit)
            frame.origin.x = Defines.Spacings.doubleUnit
            super.frame = frame
        }
    }
    
    
    // MARK : Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCell()
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
    fileprivate func setupCell() {
        self.backgroundColor = Defines.Colors.white
        self.selectionStyle = .none
        self.layer.masksToBounds = true
    }
    
    fileprivate func addSubviews() {
        self.contentView.addSubview(self.issueImageView)
        self.contentView.addSubview(self.issueTitleView)
    }
    
    fileprivate func setupLayoutConstraints() {
        let spacing = Defines.Spacings.doubleUnit
        
        let trailingConstraintOfTitleView = self.issueTitleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                                                          constant: -spacing)
        trailingConstraintOfTitleView.priority = UILayoutPriorityDefaultLow - 1
        NSLayoutConstraint.activate([
            self.issueImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.issueImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.issueImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.issueImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.issueTitleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                         constant: spacing),
            self.issueTitleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                        constant: -spacing),
            trailingConstraintOfTitleView
        ])
    }
    
    // MARK : Public Interface
    func configure(with model: IssueViewModel) {
        self.issueTitleLabel.text = model.title
    }
}

