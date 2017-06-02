//
//  TableViewDataSourceProtocol.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

protocol TableViewDataSourceProtocol {
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func dataSource(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func dataSource(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}
