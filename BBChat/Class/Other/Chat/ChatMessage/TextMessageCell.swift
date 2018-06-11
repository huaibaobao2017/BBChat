//
//  TextMessageCell.swift
//  BBChat
//
//  Created by bb on 2018/1/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class TextMessageCell: BaseMessageCell {

    override var message: EMMessage? {
        didSet {
            updateUI()
        }
    }
    
    // 内容
    lazy var contentLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor.yellow
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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

extension TextMessageCell {
    
    private func setupUI() {
//        self.backgroundColor = UIColor.brown
        self.bubbleView.addSubview(contentLabel)
    }
    
    private func updateUI() {
        guard let message = self.message else { return }
        // 发送者头像
        self.avatarImageView.sd_setImage(with: MessageHelper.shared.avatarUrl(message: message), placeholderImage: UIImage(named: "demo6"))
        // 发送者昵称
        self.nickNameLabel.text = MessageHelper.shared.nickName(message: message)
        // 消息内容
        self.contentLabel.text = ((message.body as? EMTextMessageBody)?.text)!
        // 设置泡泡
        let insert = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        var normalImg = message.direction == EMMessageDirectionSend ? UIImage(named: "SenderTextNodeBkg") : UIImage(named: "ReceiverTextNodeBkg")
        var hightImg = message.direction == EMMessageDirectionSend ? UIImage(named: "SenderTextNodeBkg_HL") : UIImage(named: "ReceiverTextNodeBkg_HL")
        normalImg = normalImg?.resizableImage(withCapInsets: insert, resizingMode: .stretch)
        hightImg = hightImg?.resizableImage(withCapInsets: insert, resizingMode: .stretch)
        bubbleView.setBackgroundImage(normalImg, for: .normal)
        bubbleView.setBackgroundImage(hightImg, for: .highlighted)
        // 重新布局
        layoutSubview()
    }
    
    private func layoutSubview() {
        // 发送
        if self.message?.direction == EMMessageDirectionSend {
            contentLabel.snp.removeConstraints()
            contentLabel.snp.makeConstraints { (make) in
                make.right.equalTo(bubbleView).offset(-15)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-15)
            }
            bubbleView.snp.removeConstraints()
            bubbleView.snp.makeConstraints { (make) in
                make.right.equalTo(avatarImageView.snp.left).offset(-5)
                make.height.greaterThanOrEqualTo(avatarImageView).offset(4)
                make.top.equalTo(nickNameLabel.snp.bottom).offset(-2)
                make.bottom.equalTo(self.contentView).offset(-10)
                make.width.lessThanOrEqualTo(MGScreenW - 120)
            }
        } else { // 接收
            contentLabel.snp.removeConstraints()
            contentLabel.snp.makeConstraints { (make) in
                make.left.equalTo(bubbleView).offset(15)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-15)
            }
            bubbleView.snp.removeConstraints()
            bubbleView.snp.makeConstraints { (make) in
                make.left.equalTo(avatarImageView.snp.right).offset(5)
                make.height.greaterThanOrEqualTo(avatarImageView).offset(4)
                make.top.equalTo(nickNameLabel.snp.bottom).offset(-2)
                make.bottom.equalTo(self.contentView).offset(-10)
                make.width.lessThanOrEqualTo(MGScreenW - 120)
            }
        }
        
    }
    
}

