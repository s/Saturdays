//
//  IssueDetailsVenueCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/13/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsVenueCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationInfoLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
}

extension IssueDetailsVenueCell : ConfigurableCell {
    func configure(with model: Venue) {
        self.nameLabel.text = model.name
        self.typeLabel.text = model.type
        self.locationInfoLabel.text = model.locationInfo
    }
    
    func updateCell(with image: UIImage) {
        self.photoImageView.image = image
    }
    
    func updateCellImageDownloadStatus(with fractionCompleted: Double) {}
}
