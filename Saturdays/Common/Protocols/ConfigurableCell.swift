//
//  ConfigurableCell
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype Model
    func configure(with model: Model)
}
