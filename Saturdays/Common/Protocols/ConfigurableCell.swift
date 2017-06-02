//
//  ConfigurableCell
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype Model: ImageDownloadableModel, ExternallyOpenable
    func configure(with model: Model)
    func updateCell(with image: UIImage)
    func updateCellImageDownloadStatus(with fractionCompleted: Double)
}
