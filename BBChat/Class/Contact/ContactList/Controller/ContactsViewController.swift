//
//  ContactsViewController.swift
//  BBChat
//
//  Created by bb on 2018/4/24.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import LeanCloud

private let KContactListTableViewCellID = "KContactListTableViewCellID"

class ContactsViewController: BaseListViewController {
    
    lazy var vm = ContactListViewModel()
    
    /// 环信 聊天id
    var chatIds = [String]() {
        didSet {
            loadContactData()
        }
    }
    
    /// 排序后的联系人 模型
    var contacts = [SortedContact]() {
        didSet {
            updateUI()
        }
    }
    
    lazy var searchController: MultipleSearchViewController = { [unowned self] in
        let searchController = MultipleSearchViewController(searchResultsController: MultipleSearchResultsViewController())
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    /// 其他入口
    let sysArray = [["titleName": "新的朋友", "imageName": "plugins_FriendNotify"], ["titleName": "群聊", "imageName": "add_friend_icon_addgroup"], ["titleName": "标签", "imageName": "Contact_icon_ContactTag"], ["titleName": "公众号", "imageName": "add_friend_icon_offical"]]
    
    /// 其他入口 模型
    var sys: SortedContact {
        let sys = SortedContact()
        for i in sysArray {
            let contact = Contact()
            contact.nickName = LCString(i["titleName"]!)
            contact.avatarUrl = LCString(i["imageName"]!)
            sys.contacts.append(contact)
        }
        return sys
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

extension ContactsViewController {
    
    private func setupUI() {
        
        // MARK: -设置导航栏
        setupNavigationBar()
        
        self.definesPresentationContext = true
        /// 设置UISearchController
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = UIColor.darkGray
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(ContactListTableViewCell.self, forCellReuseIdentifier: KContactListTableViewCellID)
        
        vm.controller = self
        
        // 监听联系人列表更新
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(loadContactData))
        
    }
    
    // 设置导航栏右item
    private func setupNavigationBar() {
        let normal = "barbuttonicon_addfriends"
        let highlighted = "barbuttonicon_addfriends"
        superNavigationBar(normal: normal, highlighted: highlighted)
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    // MARK: -获取环信id
    private func loadData() {
        MGContact.getContactsFromLocal(successCallback: { chatIds in
            self.chatIds = chatIds
        })
    }
    
    // MARK: -根据环信id从云端获取联系人详细信息并排序模型
    @objc private func loadContactData() {
        // 从本地获取联系人 详细信息
        let contactData = ContactWebManager.shared.loadContactsFormCache(chatIds: chatIds)
        // 排序联系人模型
        self.contacts = ContactHelper.shared.sortedContacts(contacts: contactData)
        // 插入其他入口模型
        self.contacts.insert(sys, at: 0)
    }

}

extension ContactsViewController {
    override func rightItemAction() {
        self.navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
}

extension ContactsViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.contacts[section].firstLetter
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ContactHelper.shared.indexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vm.openViewController(indexPath: indexPath, contacts: contacts)
    }
    
}

extension ContactsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KContactListTableViewCellID, for: indexPath) as! ContactListTableViewCell
        let c = contacts[indexPath.section].contacts
        cell.contact = c[indexPath.row]
        return cell
    }
    
}

