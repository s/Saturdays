//
//  TableViewDataSourceGenericSectionModelProtocol.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

protocol TableViewDataSourceGenericSectionModelProtocol {
    func sectionModel(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func sectionModel(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func sectionModel(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func sectionModel(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
}
