//
//  MyTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/16.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    var my = BaseSetting() {
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

extension MyTableViewCell {
    
    private func setupUI() {
        self.accessoryType = .disclosureIndicator
    }
    
    private func updateUI() {
        self.imageView?.image = UIImage(named: my.imageUrl)
        self.textLabel?.text = my.title
        self.textLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    
}
