//
//  IssueDetailsTrackView.swift
//  Saturdays
//
//  Created by Said Ozcan on 13/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTrackView: UIViewController {
    
    //MARK: Properties
    fileprivate lazy var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = UIDefines.Copies.tracksTitle
        label.font = UIDefines.Fonts.subtitle
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: Lifecycle
    init(with trackViewModels:***REMOVED***TrackViewModel***REMOVED***) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    //MARK: Private
    fileprivate func addSubviews() {
        self.view.addSubview(self.titleLabel)
    }
    
    fileprivate func setupLayoutConstraints() {
        NSLayoutConstraint.activate(***REMOVED***
            self.titleLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
***REMOVED***)
    }
}
