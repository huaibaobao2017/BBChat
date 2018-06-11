//
//  BaseContactListTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import SDWebImage

class BaseContactListTableViewCell: BaseTableViewCell {
    
    var contact = Contact() {
        didSet {
            updateUI()
        }
    }
    
    // 联系人头像
    lazy var contactImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    // 联系人昵称
    lazy var contactNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseContactListTableViewCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        addSubview(contactImageView)
        addSubview(contactNameLabel)
    }
    
    private func updateUI() {
        // 通讯录联系人的昵称
        contactNameLabel.text = contact.nickName.stringValue ?? ""
        // 通讯录联系人的头像
        let str = contact.avatarUrl.stringValue ?? ""
        if str.hasPrefix("https://") || str.hasPrefix("http://") {
            contactImageView.sd_setImageWithPreviousCachedImage(with: URL(string: str), placeholderImage: UIImage(named: "demo6"), progress: nil)
        } else {
            contactImageView.image = UIImage(named: str)
        }
    }

}

