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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
    }
}

extension IssueDetailsPostCell : ConfigurableCell {
    func configure(with model: Post) {
        self.titleLabel.text = model.title
    }
    
    func updateCell(with image: UIImage) {
        self.photoImageView.image = image
        self.progressBar.isHidden = true
        
        let imageHeight = image.correctHeight(for: self.contentView.frame)
        self.photoImageViewHeightConstraint.constant = imageHeight
    }
    
    func updateCellImageDownloadStatus(with fractionCompleted: Double) {
        self.progressBar.animate(toAngle: 360 * fractionCompleted, duration: 0.1, completion: nil)
    }
}
