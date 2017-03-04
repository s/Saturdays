//
//  IssueDetailsTrackCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/13/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTrackCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumArtImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.albumArtImageView.image = nil
    }
}

extension IssueDetailsTrackCell : ConfigurableCell {
    func configure(with model: Track) {
        self.nameLabel.text = model.name
        self.artistLabel.text = model.artist
    }
    
    func updateCell(with image: UIImage) {
        self.albumArtImageView.image = image
    }
    
    func updateCellImageDownloadStatus(with fractionCompleted: Double) {}
}
