//
//  IssueDetailsImageDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 14/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsImageDataSource {
    
    //MARK: Properties
    fileprivate let image : UIImage?
    fileprivate let imageSize : CGSize
    
    required init(with image: UIImage?, imageSize:CGSize) {
        self.image = image
        self.imageSize = imageSize
    }
}

extension IssueDetailsImageDataSource : IssueDetailsDataSourceProtocol {
    
    var cellClass: AnyClass {
        return IssueDetailsImageCell.self
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass), for: indexPath) as! IssueDetailsImageCell
        cell.configure(with:image)
        return cell
    }
    
    func dataSource(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return imageSize.appropriateSize(for: tableView.frame.size).height
    }
}
