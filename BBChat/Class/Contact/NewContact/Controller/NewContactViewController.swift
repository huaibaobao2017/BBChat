//
//  NewContactViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

private let KNewContactAddTableViewCellID = "KNewContactAddTableViewCellID"
private let KNewContactTableViewCellID = "KNewContactTableViewCellID"

class NewContactViewController: ContactSearchListViewController {
    
    var groups: [SortedRequest]? {
        didSet {
            updateUI()
        }
    }
    
    private let vm = NewContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

extension NewContactViewController {
    
    private func setupUI() {
        setupNavigationBar()
        self.title = "新的朋友"
        self.definesPresentationContext = true
        tableView.backgroundColor = UIColor.colorHex(hex: "#efeff4")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        tableView.register(NewContactAddTableViewCell.self, forCellReuseIdentifier: KNewContactAddTableViewCellID)
        tableView.register(NewContactTableViewCell.self, forCellReuseIdentifier: KNewContactTableViewCellID)
        
        //
        self.vm.controller = self

    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }

    // 设置导航栏左右item
    private func setupNavigationBar() {
        superNavigationBar(left: nil, right: "添加朋友", isClear: false)
    }
    
}

extension NewContactViewController {
    
    private func loadData() {
        self.vm.loadData { (groups) in
            self.groups = groups
        }
    }
    
}

extension NewContactViewController {
    
    override func rightItemAction() {
        self.navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
    
}

extension NewContactViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            let title = self.groups![section - 1].sectionTitle
            return title
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.vm.pushViewController(indexPath: indexPath, requests: groups)
    }
    
}

extension NewContactViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if (self.groups) != nil {
            return (self.groups?.count)! + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.groups![section - 1].requests.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: KNewContactAddTableViewCellID, for: indexPath) as! NewContactAddTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: KNewContactTableViewCellID, for: indexPath) as! NewContactTableViewCell
            cell.request = self.groups![indexPath.section - 1].requests[indexPath.row]
            return cell
        }
    }
    
}

