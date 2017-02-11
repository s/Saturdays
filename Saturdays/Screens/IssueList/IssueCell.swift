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
import KDCircularProgress

class IssueCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var progressBar: KDCircularProgress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with issue:Issue)
    {
        self.titleLabel.text = issue.title
        guard let photoUrl = issue.coverPhoto?.url else { return }
        
        Alamofire.request(photoUrl).downloadProgress(closure: { (progress) in
            self.progressBar.animate(toAngle: 360 * progress.fractionCompleted, duration: 0.1, completion: nil)
        }).responseImage { ***REMOVED***weak self***REMOVED*** response in

            if let image = response.result.value {
                self?.coverPhotoImageView.image = image
***REMOVED***
            
            self?.progressBar.isHidden = true
        }
    }
}
