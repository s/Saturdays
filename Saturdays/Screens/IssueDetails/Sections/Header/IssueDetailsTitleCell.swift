//
//  IssueDetailsHeaderView.swift
//  Saturdays
//
//  Created by Said Ozcan on 14/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTitleCell: UITableViewCell {
    
    //MARK: Properties
    fileprivate lazy var issueTitleLabel : UILabel = { ***REMOVED***unowned self***REMOVED*** in
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIDefines.Fonts.navigationBarLargeTitleViewTitle
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        return label
    }()
    
    fileprivate lazy var issueDescriptionLabel : UILabel = { ***REMOVED***unowned self***REMOVED*** in
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIDefines.Fonts.body
        label.numberOfLines = 0
        return label
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
    
    //MARK: Lifecycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func configure(with issue:IssueViewModel) {
        issueTitleLabel.text = issue.detailTitle
        issueDescriptionLabel.text = issue.detailDescription
    }
    
    //MARK: Private
    fileprivate func setupLayout() {
        self.contentView.addSubview(self.headerStackView)
        NSLayoutConstraint.activate(***REMOVED***
            self.headerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headerStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headerStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.headerStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
***REMOVED***)
    }
}
