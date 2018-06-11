//
//  ContactSearchListViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ContactSearchListViewController: BaseListViewController {

    lazy var searchController: ContactSearchViewController = { [unowned self] in
        let searchController = ContactSearchViewController(searchResultsController: ContactSearchResultsViewController())
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "手机号"
        return searchController
    }()
    
}
