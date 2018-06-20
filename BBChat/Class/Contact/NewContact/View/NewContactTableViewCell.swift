//
//  NewContactTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/5/30.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class NewContactTableViewCell: BaseTableViewCell {
    
    var request: Request? {
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
        return view
    }()
    
    // 用户昵称
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "撒盐哥"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    // 附加消息内容
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "你好，我是撒盐哥"
        label.textColor = UIColor.colorHex(hex: "#9b9b9b")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // 查看按钮
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitle("查看", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(r: 248, g: 248, b: 248), size: CGSize(width: 50, height: 20)), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(r: 248, g: 248, b: 248), size: CGSize(width: 50, height: 20)), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.init(r: 223, g: 223, b: 223).cgColor
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.isHidden = true
        return button
    }()
    
    // 接收按钮
    private lazy var addedButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitle("已添加", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.isHidden = true
        return button
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

extension NewContactTableViewCell {
    
    private func setupUI() {
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(nickNameLabel)
        self.contentView.addSubview(messageLabel)
        self.contentView.addSubview(acceptButton)
        self.contentView.addSubview(addedButton)
    }
    
    private func updateUI() {
        userImageView.sd_setImage(with: URL(string: request?.avatarUrl.stringValue ?? ""), placeholderImage: nil)
        nickNameLabel.text = request?.nickName.stringValue ?? ""
        messageLabel.text = request?.message
        if request?.isFriend == true {
            acceptButton.isHidden = true
            addedButton.isHidden = false
        } else {
            acceptButton.isHidden = false
            addedButton.isHidden = true
        }
    }
    
    private func layoutSubview() {
        userImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(9)
            make.bottom.equalTo(self).offset(-9)
            make.width.equalTo(userImageView.snp.height)
        }
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalTo(userImageView).offset(2)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(16)
        }
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickNameLabel)
            make.bottom.equalTo(userImageView).offset(-2)
            make.right.equalTo(nickNameLabel)
            make.height.equalTo(14)
        }
        acceptButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(48)
            make.height.equalTo(30)
        }
        addedButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(48)
            make.height.equalTo(30)
        }
    }
}

