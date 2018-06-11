//
//  NickNameSettingTableViewCell.swift
//  BBChat
//
//  Created by bb on 2017/12/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class NickNameSettingTableViewCell: BaseEditingTableViewCell {
    
    private lazy var vm = NickNameSettingViewModel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NickNameSettingTableViewCell {
    
    private func setupUI() {
        textField.placeholder = "请输入名称"
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateMyNickName))
    }
    
    private func updateUI() {
        // 当前用户的环信ID
        let currentUsername = EMClient.shared().currentUsername
        textField.text = MessageHelper.shared.nickName(chatId: currentUsername)
    }

    
}

extension NickNameSettingTableViewCell {
    
    @objc private func updateMyNickName() {
        self.vm.updateMyNickName(nickName: inputText ?? "")
    }
    
}

