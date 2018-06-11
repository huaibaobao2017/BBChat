//
//  MyUserTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/17.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class MyUserTableViewCell: UITableViewCell {
    
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

extension MyUserTableViewCell {
    
    private func setupUI() {
        self.accessoryType = .disclosureIndicator
        self.imageView?.layer.cornerRadius = 5
        self.imageView?.layer.masksToBounds = true
        self.imageView?.contentMode = .scaleAspectFill
        updateUI()
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateUI))
    }
    
    @objc private func updateUI() {
        let currentUsername = EMClient.shared().currentUsername
        let avatarUrl = MessageHelper.shared.avatarUrl(chatId: currentUsername)
        let nickName = MessageHelper.shared.nickName(chatId: currentUsername)
        let name = MessageHelper.shared.chatNumber(chatId: currentUsername)
        self.imageView?.sd_setImageWithPreviousCachedImage(with: avatarUrl, placeholderImage: UIImage(named: "demo6"), progress: nil)
        self.textLabel?.text = nickName
        self.textLabel?.font = UIFont.systemFont(ofSize: 17)
        self.detailTextLabel?.text = "聊天号: \(name ?? "")"
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func layoutSubview() {
        self.imageView?.frame = CGRect(x: 15, y: 10, width: self.bounds.height - 20, height: self.bounds.height - 20)
        var tmpFrame = self.textLabel?.frame
        tmpFrame?.origin.x = self.bounds.height + 10
        tmpFrame?.origin.y = 20
        self.textLabel?.frame = tmpFrame!
        tmpFrame = self.detailTextLabel?.frame
        tmpFrame?.origin.x = self.bounds.height + 10
        tmpFrame?.origin.y = 50
        self.detailTextLabel?.frame = tmpFrame!
    }
    
}

