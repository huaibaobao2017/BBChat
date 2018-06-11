//
//  ContactSearchResultsViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Contacts
import LeanCloud

private let KContactListTableViewCellID = "KContactListTableViewCellID"
private let KPhoneContactTableViewCellID = "KPhoneContactTableViewCellID"

// 联系人搜索 结果
class ContactSearchResultsViewController: UITableViewController {
    
    var phoneContacts = [PhoneContact]() {
        didSet {
            updateUI()
        }
    }
    
    var text = ""
    
    private let vm = ContactSearchResultsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

extension ContactSearchResultsViewController {
    
    private func setupUI() {
        self.definesPresentationContext = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(ContactListTableViewCell.self, forCellReuseIdentifier: KContactListTableViewCellID)
        tableView.register(PhoneContactTableViewCell.self, forCellReuseIdentifier: KPhoneContactTableViewCellID)
        
        self.vm.controller = self
        
        NOTIFY_ADD(target: self, name: KSearchContactNotification, selector: #selector(searchContact))
    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }
    
}

extension ContactSearchResultsViewController {
    // 加载通讯录数据
    private func loadData() {
        CNContactStore().requestAccess(for: .contacts) { (successed, error) in
            if successed {
                //授权成功加载数据。
                self.vm.loadContactsData()
            }
        }
    }
    
}

extension ContactSearchResultsViewController {
    // 开始搜索联系人
    @objc private func searchContact(n: Notification) {
        self.vm.searchContact(n: n, callback: { text, phoneContacts  in
            self.text = text
            guard let phoneContacts = phoneContacts else { return }
            self.phoneContacts = phoneContacts
        })
    }
    
}

extension ContactSearchResultsViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            return "手机联系人"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.vm.openViewController(indexPath: indexPath, contacts: self.phoneContacts)
    }
    
}

extension ContactSearchResultsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.phoneContacts.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.phoneContacts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: KContactListTableViewCellID, for: indexPath) as! ContactListTableViewCell
            let contact = Contact()
            contact.avatarUrl = LCString("demo6")
            contact.nickName = LCString("搜索: \(self.text)")
            cell.contact = contact
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: KPhoneContactTableViewCellID, for: indexPath) as! PhoneContactTableViewCell
            cell.phoneContact = self.phoneContacts[indexPath.row]
            return cell
        }
    }
    
}
