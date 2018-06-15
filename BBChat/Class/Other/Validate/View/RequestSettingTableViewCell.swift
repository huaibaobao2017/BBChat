//
//  MessageSettingTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/6/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class RequestSettingTableViewCell: BaseEditingTableViewCell {
    
    var message: String? {
        didSet {
            textField.text = message
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RequestSettingTableViewCell {
    
    private func setupUI() {
        textField.placeholder = "请输入验证信息"
    }
    
    private func updateUI() {

    }
    
}
