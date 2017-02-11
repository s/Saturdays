//
//  IssueCell.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/11/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class IssueCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with issue:Issue)
    {
        self.titleLabel.text = issue.title
        
        guard let photoUrl = issue.coverPhoto?.url else { return }
        
        Alamofire.request(photoUrl).responseImage { ***REMOVED***weak self***REMOVED*** response in

            if let image = response.result.value {
                self?.coverPhotoImageView.image = image
***REMOVED***
        }
    }
}
