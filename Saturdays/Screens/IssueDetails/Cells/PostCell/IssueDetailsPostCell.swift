//
//  IssueDetailsPostCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/13/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import KDCircularProgress

class IssueDetailsPostCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBar: KDCircularProgress!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
}

extension IssueDetailsPostCell : ConfigurableCell {
    func configure(with model: Post) {
        self.titleLabel.text = model.title
    }
    
    func updateCell(with image: UIImage) {
        self.photoImageView.image = image
        self.progressBar.isHidden = true
        
        let imageHeight = ( self.contentView.frame.size.width * image.size.height ) / image.size.width
        self.photoImageViewHeightConstraint.constant = imageHeight
    }
    
    func updateCellImageDownloadStatus(with fractionCompleted: Double) {
        self.progressBar.animate(toAngle: 360 * fractionCompleted, duration: 0.1, completion: nil)
    }
}
