//
//  ContactSearchListViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ContactSearchListViewController: BaseListViewController {
    
    lazy var csvm = ContactSearchViewModel()

    lazy var searchController: ContactSearchViewController = { [unowned self] in
        let searchController = ContactSearchViewController(searchResultsController: ContactSearchResultsViewController())
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "手机号"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(getContactProfile))
    }
    
}

extension ContactSearchListViewController {
    // enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        self.csvm.searchContact(text: text, isUpdating: false)
    }
    // 实时
    override func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        self.csvm.searchContact(text: text, isUpdating: true)
    }
}

extension ContactSearchListViewController {
    // 获取联系人 详细信息
    @objc private func getContactProfile(note: Notification) {
        self.csvm.getContactProfile(note: note)
    }
}
