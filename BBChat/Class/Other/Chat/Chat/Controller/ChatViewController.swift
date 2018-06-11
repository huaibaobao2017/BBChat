//
//  ChatViewController.swift
//  ChatKeyBoard
//
//  Created by bb on 2018/1/25.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {
    
    var conversation: EMConversation?
    
    var messages: [EMMessage]? {
        didSet {
            chatMsgVC.messages = self.messages
        }
    }
    
    let offsetY = MGScreenH - MGInputBarHeight
    
    // MARK:- 记录属性
    var finishRecordingVoice: Bool = true   // 决定是否停止录音还是取消录音
    
    // MARK: 消息列表控制器
    lazy var chatMsgVC: ChatMsgViewController = { [unowned self] in
        let vc = ChatMsgViewController()
        vc.delegate = self
        return vc
    }()
    
    // MARK: 输入栏控制器
    lazy var chatBarVC: ChatBarViewController = { [unowned self] in
        let vc = ChatBarViewController()
        vc.delegate = self
        return vc
    }()
    
    // MARK: 表情面板
    lazy var emotionView: UIView = { [unowned self] in
        let view = UIView()
        return view
        }()
    // MARK: 更多面板
    lazy var moreView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
        }()
    // MARK: 录音视图
    lazy var recordVoiceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.isHidden = true
        return view
    }()

    init(conversationId: String, conversationType: EMConversationType) {
        super.init(nibName: nil, bundle: nil)
        let conversation = MGConversation.getConversation(conversationId: conversationId, type: conversationType)
        chatBarVC.conversation = conversation
        chatMsgVC.conversation = conversation
        self.conversation = conversation
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NOTIFY_POST(name: KUpdateMessage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NOTIFY_POST(name: KContactInfoDidUpdateNotification)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NOTIFY_POST(name: KUpdateMessage)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }

}

extension ChatViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.addChildViewController(chatBarVC)
        self.addChildViewController(chatMsgVC)
        self.view.addSubview(chatMsgVC.view)
        self.view.addSubview(chatBarVC.view)
        
        // 添加表情面板和更多面板
        self.view.addSubview(emotionView)
        self.view.addSubview(moreView)
        self.view.addSubview(recordVoiceView)
        
        chatBarVC.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(MGInputBarHeight)
        }
        chatMsgVC.view.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(chatBarVC.view.snp.top)
            make.height.equalTo(offsetY)
        }
        
        // 布局
        emotionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.chatBarVC.view.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(kNoTextKeyboardHeight)
        }
        moreView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(kNoTextKeyboardHeight)
            make.top.equalTo(self.emotionView.snp.bottom)
        }
        recordVoiceView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.bottom.equalTo(self.view).offset(-100)
            make.left.right.equalTo(self.view)
        }
        
        // 注册通知
        registerNote()
    }
    
    private func updateUI() {

    }
    
    // 注册通知
    private func registerNote() {
        NotificationCenter.default.addObserver(self, selector: #selector(chatBarRecordBtnLongTapBegan(_ :)), name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapBegan"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chatBarRecordBtnLongTapChanged(_ :)), name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chatBarRecordBtnLongTapEnded(_ :)), name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapEnded"), object: nil)
    }
}

// MARK:- 自身事件处理
extension ChatViewController {
    // MARK: 右上角按钮点击事件
    @objc func userInfo() {
        print("查看用户信息")
        //chatMsgVC.scrollToBottom(animated: true)
    }
    
    // MARK: 重置barView的位置
    func resetChatBarFrame() {
        if chatBarVC.keyboardType == .voice {
            return
        }
        chatBarVC.resetKeyboard()
        
        chatBarVC.view.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(0)
        })

        UIView.animate(withDuration: kKeyboardChangeFrameTime) {
            UIApplication.shared.keyWindow?.endEditing(true)
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.view.layoutIfNeeded()
        }
    }
    
    /* 录音按钮长按事件 */
    @objc func chatBarRecordBtnLongTapBegan(_ note : Notification) {
         print("长按开始")
         finishRecordingVoice = true
    }
    @objc func chatBarRecordBtnLongTapChanged(_ note : Notification) {
         print("长按平移")
    }
    @objc func chatBarRecordBtnLongTapEnded(_ note : Notification) {
         print("长按结束")
    }
}

