//
//  ProfileHeaderView.swift
//  BBChat
//
//  Created by bb on 2018/1/9.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
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
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    // 联系人昵称
    lazy var contactNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.colorHex(hex: "#333333")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 联系人聊天号
    lazy var contactNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    // 联系人性别图标
    lazy var contactSexImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    // 分隔线
    lazy var separatorTop: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.colorHex(hex: "#d9d9d9").cgColor
        layer.frame = CGRect(x: 0, y: 0, width: MGScreenW, height: 0.5)
        return layer
    }()
    // 分隔线
    lazy var separatorBottom: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.colorHex(hex: "#d9d9d9").cgColor
        layer.frame = CGRect(x: 0, y: 79.5, width: MGScreenW, height: 0.5)
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension ProfileHeaderView {
    
    private func setupUI() {
        self.layer.addSublayer(separatorTop)
        self.layer.addSublayer(separatorBottom)
        self.backgroundColor = UIColor.white
        self.addSubview(contactImageView)
        self.addSubview(contactNickNameLabel)
        self.addSubview(contactNameLabel)
        self.addSubview(contactSexImageView)
    }
    
    private func updateUI() {
        // 通讯录联系人的头像
        self.contactImageView.sd_setImage(with: URL(string: contact.avatarUrl.stringValue ?? ""), placeholderImage: UIImage(named: "demo6"))
        // 通讯录联系人的昵称
        self.contactNickNameLabel.text = contact.nickName.stringValue ?? ""
        // bb聊天号
        self.contactNameLabel.text = "聊天号: \(contact.chatNumber.stringValue ?? "")"
        let sex = contact.sex.stringValue ?? "0"
        let imageName = sex == "0" ? "Contact_Female" : "Contact_Male"
        contactSexImageView.image = UIImage(named: imageName)
    }
    
    private func layoutSubview() {
        contactImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(contactImageView.snp.height)
        }
        contactNickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contactImageView.snp.right).offset(10)
            make.top.equalTo(contactImageView).offset(5)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(15)
        }
        contactNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contactNickNameLabel)
            make.top.equalTo(contactNickNameLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(15)
        }
        contactSexImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contactNickNameLabel.snp.right)
            make.centerY.equalTo(contactNickNameLabel)
            make.height.equalTo(17)
            make.width.equalTo(17)
        }
    }
    
}
