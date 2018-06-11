//
//  PhoneContactTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/5.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class PhoneContactTableViewCell: UITableViewCell {
    
    var phoneContact: PhoneContact? = nil {
        didSet {
            updateUI()
        }
    }
    
    // 用户头像
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    // 会话标题
    private lazy var conversationNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 最新消息内容
    private lazy var lastMessageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.colorHex(hex: "#9b9b9b")
        label.font = UIFont.systemFont(ofSize: 13)
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

extension PhoneContactTableViewCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.addSubview(userImageView)
        self.addSubview(conversationNameLabel)
        self.addSubview(lastMessageLabel)
    }
    
    private func updateUI() {
        conversationNameLabel.text = phoneContact?.name
        lastMessageLabel.text = phoneContact?.phoneNumber
    }
    
    private func layoutSubview() {
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(9)
            make.bottom.equalTo(self).offset(-9)
            make.width.equalTo(userImageView.snp.height)
        }
        conversationNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalTo(userImageView)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(16)
        }
        lastMessageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conversationNameLabel)
            make.bottom.equalTo(userImageView)
            make.right.equalTo(conversationNameLabel)
            make.height.equalTo(14)
        }
    }
    
}

