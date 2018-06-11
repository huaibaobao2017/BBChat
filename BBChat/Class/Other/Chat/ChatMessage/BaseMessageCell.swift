//
//  BaseMessageCell.swift
//  BBChat
//
//  Created by bb on 2018/1/10.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class BaseMessageCell: BaseTableViewCell {
    
    var message: EMMessage? {
        didSet {
            updateUI()
        }
    }

    // 联系人头像
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    // 联系人昵称
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(hex: "#737373")
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    // 内容外观
    lazy var bubbleView: UIButton = {
        let view = UIButton()
        view.adjustsImageWhenHighlighted = false
//        view.backgroundColor = UIColor.red
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseMessageCell {
    
    private func setupUI() {
        self.backgroundColor = UIColor.colorHex(hex: "#ebebeb")
        self.selectionStyle = .none
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(nickNameLabel)
        self.contentView.addSubview(bubbleView)
    }
    
    private func updateUI() {
        // 重新布局
        layoutSubview()
    }
    
    private func layoutSubview() {
        // 发送
        if self.message?.direction == EMMessageDirectionSend {
            avatarImageView.snp.removeConstraints()
            avatarImageView.snp.makeConstraints { (make) in
                make.right.equalTo(-10)
                make.top.equalTo(self.contentView).offset(10)
                make.height.equalTo(40)
                make.width.equalTo(avatarImageView.snp.height)
            }
            nickNameLabel.snp.removeConstraints()
            nickNameLabel.snp.makeConstraints { (make) in
                make.right.equalTo(avatarImageView.snp.left).offset(-10)
                make.top.equalTo(avatarImageView)
                make.width.greaterThanOrEqualTo(40)
                make.height.equalTo(0) // 12
            }
        } else { // 接收
            avatarImageView.snp.removeConstraints()
            avatarImageView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(self.contentView).offset(10)
                make.height.equalTo(40)
                make.width.equalTo(avatarImageView.snp.height)
            }
            nickNameLabel.snp.removeConstraints()
            nickNameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(avatarImageView.snp.right).offset(10)
                make.top.equalTo(avatarImageView)
                make.width.greaterThanOrEqualTo(40)
                make.height.equalTo(0) // 12
            }
        }

    }
    
}
