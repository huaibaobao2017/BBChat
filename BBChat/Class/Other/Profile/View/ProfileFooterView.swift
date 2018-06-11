//
//  ProfileFooterView.swift
//  BBChat
//
//  Created by bb on 2018/1/9.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class ProfileFooterView: UIView {
    
    var contact: Contact? = nil
    
    var isFriend = false {
        didSet {
            updateUI()
        }
    }
    
    weak var controller: UIViewController? = nil
    
    // 添加到通讯录/发送信息 按钮
    lazy var addOrSendButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor.withAlphaComponent(0.8)), for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addOrSend), for: .touchUpInside)
        return button
    }()
    
    // 视频聊天 按钮
    lazy var videoChatButton: UIButton = {
        let button = UIButton()
        button.setTitle("视频聊天", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.lightGray.withAlphaComponent(0.8)), for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(videoChat), for: .touchUpInside)
        return button
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

extension ProfileFooterView {
    
    private func setupUI() {
        self.addSubview(addOrSendButton)
        self.addSubview(videoChatButton)
    }
    
    private func updateUI() {
        if isFriend == true {
            addOrSendButton.setTitle("发消息", for: .normal)
        } else {
            addOrSendButton.setTitle("添加到通讯录", for: .normal)
            videoChatButton.isHidden = true
        }
    }
    
    private func layoutSubview() {
        addOrSendButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(44)
        }
        videoChatButton.snp.makeConstraints { (make) in
            make.left.equalTo(addOrSendButton)
            make.top.equalTo(addOrSendButton.snp.bottom).offset(15)
            make.right.equalTo(addOrSendButton)
            make.height.equalTo(addOrSendButton)
        }
    }
}

extension ProfileFooterView {
    
    @objc private func addOrSend() {
        guard let contact = self.contact else { return }
        if isFriend == true {
            let vc = ChatViewController(conversationId: contact.chatId.stringValue ?? "", conversationType: EMConversationTypeChat)
            vc.title = contact.nickName.stringValue ?? ""
            self.controller?.navigationController?.pushViewController(vc, animated: true)
            print("发送信息，新建或打开会话")
        } else {
            print("添加到通讯录 ")
            let vc = RequestSettingViewController(style: .grouped)
            vc.contact = contact
            self.controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func videoChat() {
        print("video chat")
    }
    
}
