//
//  AddContactViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/19.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

private let KAddContactTableViewCellID = "KAddContactTableViewCellID"

class AddContactViewController: ContactSearchListViewController {

    private lazy var vm = AddContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension AddContactViewController {
    
    private func setupUI() {
        self.title = "添加朋友"
        self.definesPresentationContext = true
        tableView.backgroundColor = UIColor.colorHex(hex: "#efeff4")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: KAddContactTableViewCellID)
        
        self.vm.controller = self
        self.csvm.controller = self
    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }
    
}

extension AddContactViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.vm.openViewController(indexPath: indexPath)
    }
    
}

extension AddContactViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KAddContactTableViewCellID, for: indexPath)
        return cell
    }
    
}
