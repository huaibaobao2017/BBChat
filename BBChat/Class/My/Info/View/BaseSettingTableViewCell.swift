//
//  BaseSettingTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/17.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class BaseSettingTableViewCell: UITableViewCell {

    var setting = "" {
        didSet {
            updateUI()
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

extension BaseSettingTableViewCell {
    
    private func setupUI() {
        self.accessoryType = .disclosureIndicator
    }
    
    func updateUI() {
        self.textLabel?.text = setting
        self.textLabel?.font = UIFont.systemFont(ofSize: 17)
        self.detailTextLabel?.text = "123"
    }
    
}

