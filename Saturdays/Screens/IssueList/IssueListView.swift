//
//  IssueListView.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/11/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueListView: UIViewController {
    
    fileprivate let issueService: IssueService = IssueService()
    fileprivate var issues: ***REMOVED***Issue***REMOVED*** = ***REMOVED******REMOVED***

    @IBOutlet weak var issuesCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.retrieveIssues()
        self.registerCell()
    }
    
    fileprivate func retrieveIssues()
    {
        self.issueService.get { (result) in
            switch result {
            case .success(let issues):
                self.issues = issues
                
            case .failure(let error):
                print(error)
***REMOVED***
        }
    }
    
    fileprivate func registerCell() {
        self.issuesCollectionView.register(nib:IssueCell.self)
    }
}

extension IssueListView: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let issue = self.issues***REMOVED***indexPath.row***REMOVED***
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueCell.name,
                                                      for: indexPath) as! IssueCell
        cell.configure(with: issue)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return self.issues.count
    }
}

extension IssueListView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellHeight : CGFloat = 250.0
        return CGSize(width: self.view.frame.size.width, height: cellHeight)
    }
}
