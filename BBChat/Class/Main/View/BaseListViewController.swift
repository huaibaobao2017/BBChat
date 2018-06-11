//
//  BaseListViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class BaseListViewController: UITableViewController {

}

extension BaseListViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        NOTIFY_POST(name: KSearchControllerDelegate, userInfo: ["active": false])
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        NOTIFY_POST(name: KSearchControllerDelegate, userInfo: ["active": true])
    }

}

extension BaseListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIApplication.shared.statusBarStyle = .default
        searchBar.showsCancelButton = true
        guard let button = searchBar.value(forKey: "cancelButton") as? UIButton else { return false }
        button.setTitleColor(mainColor, for: .normal)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

extension BaseListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
