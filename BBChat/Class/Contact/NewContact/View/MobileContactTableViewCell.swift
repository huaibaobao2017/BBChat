//
//  MobileContactTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/6/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class MobileContactTableViewCell: BaseTableViewCell {
    
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
    
    // 接收按钮
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitle("接受", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor, size: CGSize(width: 50, height: 20)), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor, size: CGSize(width: 50, height: 20)), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
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

extension MobileContactTableViewCell {
    
    private func setupUI() {
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(nickNameLabel)
        self.contentView.addSubview(messageLabel)
        self.contentView.addSubview(acceptButton)
    }
    
    private func updateUI() {
        userImageView.sd_setImage(with: URL(string: request?.avatarUrl.stringValue ?? ""), placeholderImage: nil)
        nickNameLabel.text = request?.nickName.stringValue ?? ""
        messageLabel.text = request?.message
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
        }
    }
}
