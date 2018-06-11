//
//  ChatBarViewController.swift
//  ChatKeyBoard
//
//  Created by bb on 2018/1/26.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import SnapKit
import Hyphenate

var kKeyboardChangeFrameTime: TimeInterval = 0.25
let kNoTextKeyboardHeight: CGFloat = 216.0

protocol ChatBarViewControllerDelegate : NSObjectProtocol {
    func chatBarShowTextKeyboard()
    func chatBarShowVoice()
    func chatBarShowEmotionKeyboard()
    func chatBarShowMoreKeyboard()
    func chatBarUpdateHeight(height: CGFloat)
    func chatBarVC(chatBarVC: ChatBarViewController, didChageChatBoxBottomDistance distance: CGFloat)
}

class ChatBarViewController: UIViewController {
    
    /// 当前会话
    var conversation: EMConversation?
    
    // MARK:- 记录属性
    var keyboardFrame: CGRect?
    var keyboardType: ChatKeyboardType?
    
    // MARK:- 代理
    weak var delegate: ChatBarViewControllerDelegate?
    
    lazy var chatBarView: ChatBarView = { [unowned self] in
        let view = ChatBarView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ChatBarViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(chatBarView)
        chatBarView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        // 监听键盘
        registerNote()
    }
    
    private func updateUI() {
        
    }
    
    // 监听键盘
    private func registerNote() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}


// MARK:- 键盘监听事件
extension ChatBarViewController {
    @objc private func keyboardWillHide(_ note: NSNotification) {
        keyboardFrame = CGRect.zero
        if chatBarView.keyboardType == .emotion || chatBarView.keyboardType == .more {
            return
        }
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: keyboardFrame?.height ?? 0)
    }
    
    @objc private func keyboardWillShow(_ note: NSNotification) {
        keyboardFrame = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect?
        if chatBarView.keyboardType == .emotion || chatBarView.keyboardType == .more {
            return
        }
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: keyboardFrame?.height ?? 0)
    }
}

// MARK:- 对外提供的方法
extension ChatBarViewController {
    func resetKeyboard() {
        chatBarView.resetBtnsUI()
        chatBarView.keyboardType = .noting
    }
}

// MARK:- 发送信息
extension ChatBarViewController {
    func sendMessage() {
        // 取出字符串
        //let message = chatBarView.inputTextView.getEmotionString()
        // 发送
        sendTextMessage(text: chatBarView.inputTextView.text)
    }
    
    // 发送文本消息
    private func sendTextMessage(text: String) {
        // 构建文本消息
        guard let message = MGMessage.textMessage(text: text, conversation: conversation) else {
            print("发送失败")
            return
        }
        // 发送消息
        print("发送了吗？\(message.body.type)")
        MGMessage.sendMessage(message: message)
        
        chatBarView.inputTextView.text = ""
    }
}


