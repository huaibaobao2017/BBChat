//
//  RequestSettingViewController.swift
//  BBChat
//
//  Created by bb on 2018/6/1.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

private let KSettingTableViewCellID = "KSettingTableViewCellID"

class RequestSettingViewController: BaseSettingViewController {
    
    var contact = Contact() {
        didSet {

        }
    }
    // 附加信息，本地缓存
    var message: String {
        let str = UserDefaults.standard.string(forKey: "requestMessage")
        return str ?? "你好，可以加我为好友吗？"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KSettingTableViewCellID, for: indexPath) as! RequestSettingTableViewCell
        cell.controller = self
        cell.message = message
        return cell
    }

}

extension RequestSettingViewController {
    
    private func setupUI() {
        self.title = "朋友验证"
        tableView.register(RequestSettingTableViewCell.self, forCellReuseIdentifier: KSettingTableViewCellID)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        superNavigationBar(left: nil, right: "发送", isClear: false)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
}

extension RequestSettingViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "你需要发送验证申请，等对方通过"
    }

}

extension RequestSettingViewController {
    
    override func leftItemAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func rightItemAction() {
        print("发送!\(message)")
        MGContact.addContact(chatId: contact.chatId.stringValue ?? "", message: message)
    }
    
}
