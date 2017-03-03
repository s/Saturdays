//
//  IssueDetailsPostCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/13/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with model: Post) {
        self.titleLabel.text = model.title
    }
}
