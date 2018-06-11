//
//  MessageViewController.swift
//  BBChat
//
//  Created by bb on 2018/4/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import MJRefresh
import Hyphenate

protocol ChatMsgViewControllerDelegate: NSObjectProtocol {
    func chatMsgVCWillBeginDragging(chatMsgVC: ChatMsgViewController)
}

let KMessageCellID = "KMessageCellID"

class ChatMsgViewController: UITableViewController {
    
    /// 当前会话
    var conversation: EMConversation?
    
    /// 已加载的历史消息
    var messages: [EMMessage]? {
        didSet {
            updateUI()
        }
    }
    
    /// 是否首次进入
    var isFirstLoad = true
    
    // MARK: - 代理
    weak var delegate: ChatMsgViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLoad {
            self.scrollsToBottom(animated: false)
        }
    }
    
}

extension ChatMsgViewController {
    
    private func setupUI() {
        self.definesPresentationContext = true
        /// 设置UITableView属性
        tableView.backgroundColor = UIColor.colorHex(hex: "#ebebeb")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadMoreData()
        })
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.stateLabel.isHidden = true
        header?.arrowView.isHidden = true
        tableView.mj_header = header
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: KMessageCellID)
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
}

extension ChatMsgViewController {
    // MARK: - 加载历史消息
    func loadMoreData() {
        HistoryHelper.shared.loadHistoryMessage(conversation: conversation, isFirstPage: false) { (historys) in
            guard let historys = historys, !historys.isEmpty else {
                print("已加载全部数据")
                self.tableView.mj_header.endRefreshing()
                return
            }
            self.messages! = historys + self.messages!
            let count = historys.count
            if count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: count, section: 0), at: .top, animated: false)
            }
            self.tableView.mj_header.endRefreshing()
        }
    }
    
}

extension ChatMsgViewController {
    // MARK: - 滚动到最底部
    func scrollsToBottom(animated: Bool = false) {
        let s = tableView.numberOfSections
        if s < 1 { return }
        let r = tableView.numberOfRows(inSection: s - 1)
        if r < 1 { return }
        let ip = IndexPath(row: r - 1, section: s - 1)
        if isFirstLoad || animated {
            isFirstLoad = false
            tableView.scrollToRow(at: ip, at: .bottom, animated: animated)
        }
        print("开始滚动了")
    }
    
}

extension ChatMsgViewController {
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !tableView.showsVerticalScrollIndicator {
            tableView.showsVerticalScrollIndicator = true
        }
        delegate?.chatMsgVCWillBeginDragging(chatMsgVC: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ChatMsgViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages != nil ? messages!.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KMessageCellID, for: indexPath) as! TextMessageCell
        cell.message = messages![indexPath.row]
        return cell
    }
    
}
