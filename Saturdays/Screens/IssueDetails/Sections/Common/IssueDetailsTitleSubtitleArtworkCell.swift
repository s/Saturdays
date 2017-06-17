//
//  IssueDetailsTitleSubtitleArtworkCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTitleSubtitleArtworkCell : UITableViewCell {
    
    //MARK: Properties
    let mediaImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIDefines.Colors.lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = UIDefines.Sizes.issueListCellCornerRadius
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var stackView : UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIDefines.Spacings.singleUnit / 2
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackViewAlignment.top
        
        return stackView
    }()
    
    //MARK: Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func configure(with labels:[UILabel]) {
        for label in self.stackView.arrangedSubviews {
            self.stackView.removeArrangedSubview(label)
            label.removeFromSuperview()
        }
        for label in labels {
            self.stackView.addArrangedSubview(label)
        }
        self.stackView.setNeedsLayout()
    }
    
    //MARK: Private
    fileprivate func setupLayout() {
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    fileprivate func addSubviews() {
        self.contentView.addSubview(self.mediaImageView)
        self.contentView.addSubview(self.stackView)
    }
    
    fileprivate func setupLayoutConstraints() {
        let imageViewBottomConstraint = self.mediaImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant:-UIDefines.Spacings.singleUnit)
        imageViewBottomConstraint.priority = UILayoutPriorityDefaultHigh - 1
        
        let stackViewBottomConstraint = self.stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant:-UIDefines.Spacings.singleUnit)
        stackViewBottomConstraint.priority = UILayoutPriorityDefaultHigh - 1
        
        NSLayoutConstraint.activate([
            self.mediaImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:UIDefines.Spacings.singleUnit),
            self.mediaImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.mediaImageView.widthAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsTrackAlbumArtDimension),
            self.mediaImageView.heightAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsTrackAlbumArtDimension),
            imageViewBottomConstraint,
            
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:UIDefines.Spacings.singleUnit),
            self.stackView.leadingAnchor.constraint(equalTo: self.mediaImageView.trailingAnchor, constant:UIDefines.Spacings.singleUnit),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit),
            stackViewBottomConstraint
        ])
    }
}

