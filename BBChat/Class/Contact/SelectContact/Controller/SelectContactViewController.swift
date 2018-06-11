////
////  SelectContactViewController.swift
////  BBChat
////
////  Created by bb on 2018/1/2.
////  Copyright © 2018年 bb. All rights reserved.
////
//
//import UIKit
//import Hyphenate
//
//class SelectContactViewController: UITableViewController {
//
//    var contacts = [Contact]() {
//        didSet {
//            updateUI()
//        }
//    }
//
//    private lazy var selectContactView: SelectContactView = {
//        let view = SelectContactView()
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//}
//
//extension SelectContactViewController {
//
//    private func setupUI() {
//        self.title = "选择联系人"
//        self.definesPresentationContext = true
//        self.selectContactView.frame = self.view.bounds
//        self.selectContactView.controller = self
//        self.selectContactView.delegate = self
//        self.view = selectContactView
//        setupNavigationBar()
//    }
//
//    private func updateUI() {
//        if self.contacts.isEmpty != true {
//            self.navigationItem.rightBarButtonItem?.isEnabled = true
//            self.navigationItem.rightBarButtonItem?.title = "完成(\(self.contacts.count))"
//            self.navigationItem.rightBarButtonItem?.tintColor = navBarTintColor
//        } else {
//            self.navigationItem.rightBarButtonItem?.title = "完成"
//            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
//            self.navigationItem.rightBarButtonItem?.isEnabled = false
//        }
//    }
//
//    // 设置导航栏左右item
//    private func setupNavigationBar() {
//        superNavigationBar(left: "取消", right: "完成", isClear: false)
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
//    }
//
//}
//
//extension SelectContactViewController {
//
//    override func rightItemAction() {
//        let invitees = contacts.flatMap { (contact) -> String? in
//            return nil //contact.userId
//        }
//        // 创建群组
//        MGGroup.createGroup(invitees: invitees) { (group) in
//            self.dismiss(animated: false, completion: nil)
//            // 通知会话列表 打开会话页
//            NOTIFY_POST(name: KCreatGroupNotification, userInfo: ["group": group])
//            // 群组创建成功，发送系统消息
//            self.sendSystemMessage(group: group)
//        }
//    }
//
//    // 发送系统消息
//    private func sendSystemMessage(group: EMGroup) {
//        guard let message = MGMessage.groupSystemMessage(text: "发起了聊天", group: group) else { return }
//        MGMessage.sendMessage(message: message)
//    }
//
//}
//
//extension SelectContactViewController: SelectContactViewDelegate {
//    // 选择联系人 代理
//    func didSelectContacts(contacts: [Contact]) {
//        self.contacts = contacts
//    }
//
//}

