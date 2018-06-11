//
//  ChatListViewController.swift
//  BBChat
//
//  Created by bb on 2018/4/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

private let KChatListCellID = "KChatListCellID"

class ChatListViewController: BaseListViewController {
    
    private var vm: [ChatListVM]? {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

extension ChatListViewController {
    
    private func setupUI() {
        self.definesPresentationContext = true
        /// 设置UISearchController
        tableView.tableHeaderView = searchController.searchBar
        if #available(iOS 11.0, *) {
//            navigationItem.searchController = searchController
//            tableView.contentInsetAdjustmentBehavior = .never
        }
        /// 设置UITableView属性
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(ChatListCell.self, forCellReuseIdentifier: KChatListCellID)
        /// 设置导航按钮
        setupNavigationBar()
        /// 监听消息到更新（发送／接收）
        NOTIFY_ADD(target: self, name: KUpdateMessage, selector: #selector(loadData))
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateUI))
        NOTIFY_ADD(target: self, name: KCreatGroupNotification, selector: #selector(didCreatGroup))
    }
    
    @objc private func updateUI() {
        tableView.reloadData()
    }
    
}

extension ChatListViewController {
    /// 加载会话列表数据
    @objc private func loadData() {
        let a = MGConversation.conversations
        // 所有未读消息数
        var count = 0
        /// 利用ChatListViewModel处理模型数据
        self.vm = a.flatMap { (c) -> ChatListVM in
            count += Int(c.unreadMessagesCount)
            return ChatListVM(conversation: c)
        }
        MGUserDefault.saveSessionMessageCount(count: count)
        NOTIFY_POST(name: KMessagesDidReceive)
        // 更新标题
        if(count != 0) {
            self.navigationController?.title = "消息(\(count))"
        } else {
            self.navigationController?.title = "消息"
        }
    }
}

extension ChatListViewController {
    
    /// 设置导航栏右item
    private func setupNavigationBar() {
        let normal = "barbuttonicon_add"
        let highlighted = "barbuttonicon_add"
        superNavigationBar(normal: normal, highlighted: highlighted)
    }
    /// rightItem点击事件
    override func rightItemAction() {
//        let nav = BaseNavigationController(rootViewController: SelectContactViewController())
//        self.present(nav, animated: true, completion: nil)
    }
    
    /// 监听成功创建群聊事件
    @objc func didCreatGroup(n: Notification) {
        guard let userInfo = n.userInfo as? [String: EMGroup] else { return }
        guard let group = userInfo["group"] else { return }
        let vc = ChatViewController(conversationId: group.groupId, conversationType: EMConversationTypeGroupChat)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatListViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vm![indexPath.row].openViewController(from: self)
        vm![indexPath.row].conversation?.markAllMessages(asRead: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            let conversation = self.vm![indexPath.row]
            guard let conversationId = conversation.conversation?.conversationId else { return }
            // 删除会话
            MGConversation.deleteConversation(conversationId: conversationId, successCallback: {
                // 删除成功 回调,重新获取本地数据
                self.loadData()
            })
        }
        let read = UITableViewRowAction(style: .normal, title: "标为已读") { (action, indexPath) in
            print("mark read")
        }
        return [delete, read]
    }
    
}

extension ChatListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm != nil ? vm!.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KChatListCellID, for: indexPath) as! ChatListCell
        cell.conversation = vm![indexPath.row]
        return cell
    }
    
}
