//
//  MultipleSearchListViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class MultipleSearchListViewController: BaseListViewController {

    lazy var searchController: MultipleSearchViewController = { [unowned self] in
        let searchController = MultipleSearchViewController(searchResultsController: MultipleSearchResultsViewController())
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        return searchController
    }()
    
}
