//
//  ConversationListTableViewCell.swift
//  BBChat
//
//  Created by bb on 2017/12/18.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import BadgeSwift
import Hyphenate

class ChatListCell: BaseTableViewCell {
    
    var conversation: ChatListVM? {
        didSet {
            updateUI()
        }
    }
    
    // 用户头像
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    // 会话标题
    private lazy var conversationNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    // 最新消息内容
    private lazy var lastMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(hex: "#9b9b9b")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    // 发送／接收 最新消息时间
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(hex: "#9b9b9b")
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    // 未读消息数
    private lazy var unreadMessagesLabel: BadgeSwift = {
        let label = BadgeSwift()
        label.badgeColor = UIColor.red
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.cornerRadius = 9
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChatListCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.addSubview(userImageView)
        self.addSubview(conversationNameLabel)
        self.addSubview(lastMessageLabel)
        self.addSubview(timeLabel)
        self.addSubview(unreadMessagesLabel)
    }
    
    private func updateUI() {
        // 会话对方的头像
        userImageView.sd_setImageWithPreviousCachedImage(with: conversation?.iconUrl, placeholderImage: UIImage(named: "demo6"), progress: nil)
        // 会话标题
        conversationNameLabel.text = conversation?.title
        // 最新消息
        lastMessageLabel.text = conversation?.message
        // 发送／接收 最新消息时间
        timeLabel.text = conversation?.time
        // 未读消息
        let unreadMessagesCount = conversation?.unreadCount
        unreadMessagesLabel.text = unreadMessagesCount
        unreadMessagesLabel.isHidden = unreadMessagesCount == nil ? true : false
    }
    
    private func layoutSubview() {
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(9)
            make.bottom.equalTo(self).offset(-9)
            make.width.equalTo(userImageView.snp.height)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self).offset(15)
            make.width.greaterThanOrEqualTo(20)
            make.height.equalTo(10)
        }
        conversationNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalTo(timeLabel)
            make.right.equalTo(timeLabel.snp.left).offset(-15)
            make.height.equalTo(16)
        }
        lastMessageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conversationNameLabel)
            make.centerY.equalTo(self.bounds.height * 2 / 3 + 1)
            make.right.equalTo(conversationNameLabel)
            make.height.equalTo(14)
        }
        unreadMessagesLabel.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.centerX.equalTo(userImageView.snp.right).offset(-3)
            make.centerY.equalTo(userImageView.snp.top).offset(2)
            make.width.greaterThanOrEqualTo(unreadMessagesLabel.snp.height)
        }

    }
}

