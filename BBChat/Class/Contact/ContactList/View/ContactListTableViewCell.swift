//
//  ContactListTableViewCell.swift
//  BBChat
//
//  Created by bb on 2017/12/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SDWebImage

class ContactListTableViewCell: BaseContactListTableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }

}

extension ContactListTableViewCell {
    
    private func layoutSubview() {
        contactImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(contactImageView.snp.height)
        }
        contactNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contactImageView.snp.right).offset(10)
            make.top.equalTo(contactImageView)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(contactImageView)
        }
    }

}

