//
//  ChatBarView.swift
//  ChatKeyBoard
//
//  Created by bb on 2018/1/26.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import SnapKit

let kSplitLineColor: UIColor = UIColor.colorHex(hex: "#dddddd")
let kChatKeyboardBgColor: UIColor = UIColor.colorHex(hex: "#f5f5f6")
let kChatBarOriginHeight: CGFloat = 49.0
let kChatBarTextViewMaxHeight: CGFloat = 100
let kChatBarTextViewHeight: CGFloat = kChatBarOriginHeight - 14.0

protocol ChatBarViewDelegate: NSObjectProtocol {
    func chatBarShowTextKeyboard()
    func chatBarShowVoice()
    func chatBarShowEmotionKeyboard()
    func chatBarShowMoreKeyboard()
    func chatBarUpdateHeight(height: CGFloat)
    func chatBarSendMessage()
}

enum ChatKeyboardType: Int {
    case noting
    case voice
    case text
    case emotion
    case more
}

class ChatBarView: UIView {
    
    var keyboardType: ChatKeyboardType = .noting
    weak var delegate: ChatBarViewDelegate?
    var inputTextViewCurHeight: CGFloat = kChatBarOriginHeight
    // 录音按钮bound
    var recordButtonBounds = CGRect.zero
    // 长按手势
    var long: UILongPressGestureRecognizer? = nil
    
    lazy var voiceButton: UIButton = {
        let voiceBtn = UIButton(type: .custom)
        voiceBtn.addTarget(self, action: #selector(voiceBtnClick(_:)), for: .touchUpInside)
        return voiceBtn
    }()
    lazy var emotionButton: UIButton = {
        let emotionBtn = UIButton(type: .custom)
        emotionBtn.addTarget(self, action: #selector(emotionBtnClick(_:)), for: .touchUpInside)
        return emotionBtn
    }()
    lazy var moreButton: UIButton = {
        let moreBtn = UIButton(type: .custom)
        moreBtn.addTarget(self, action: #selector(moreBtnClick(_:)), for: .touchUpInside)
        return moreBtn
    }()
    
    lazy var recordButton: UIButton = {
        let recordBtn = UIButton(type: .custom)
        recordBtn.backgroundColor = UIColor.white
        recordBtn.setTitle("按住 说话", for: .normal)
        recordBtn.setTitle("松开 结束", for: .highlighted)
        recordBtn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.hexInt(0xF3F4F8)), for: .normal)
        recordBtn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.hexInt(0xC6C7CB)), for: .highlighted)
        recordBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        recordBtn.setTitleColor(UIColor.darkGray, for: .normal)
        recordBtn.setTitleColor(UIColor.darkGray, for: .highlighted)
        recordBtn.layer.cornerRadius = 4.0
        recordBtn.layer.masksToBounds = true
        recordBtn.layer.borderColor = kSplitLineColor.cgColor
        recordBtn.layer.borderWidth = 0.5
        recordBtn.isHidden = true
        return recordBtn
    }()
    
    lazy var inputTextView: UITextView = { [unowned self] in
        let inputV = UITextView()
        inputV.font = UIFont.systemFont(ofSize: 15.0)
        inputV.textColor = UIColor.black
        inputV.returnKeyType = .send
        inputV.enablesReturnKeyAutomatically = true
        inputV.layer.cornerRadius = 4.0
        inputV.layer.masksToBounds = true
        inputV.layer.borderColor = kSplitLineColor.cgColor
        inputV.layer.borderWidth = 0.5
        inputV.delegate = self
        inputV.addObserver(self, forKeyPath: "attributedText", options: .new, context: nil)
        return inputV
    }()
    
    //
    
    private lazy var testImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bar")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置按钮图片
        self.resetBtnsUI()
        // 初始化UI
        self.setupUI()
        // 初始化事件
        self.setupEvents()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        inputTextView.removeObserver(self, forKeyPath: "attributedText")
    }
    
}

extension ChatBarView {
    
    private func setupUI() {
        self.backgroundColor = kChatKeyboardBgColor
        self.addSubview(voiceButton)
        self.addSubview(emotionButton)
        self.addSubview(moreButton)
        self.addSubview(inputTextView)
        self.addSubview(recordButton)
        
        // 布局
        voiceButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.width.height.equalTo(35)
            make.bottom.equalTo(self).offset(-7)
        }
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-5)
            make.width.height.equalTo(35)
            make.bottom.equalTo(self).offset(-7)
        }
        emotionButton.snp.makeConstraints { (make) in
            make.right.equalTo(moreButton.snp.left)
            make.width.height.equalTo(35)
            make.bottom.equalTo(self).offset(-7)
        }
        inputTextView.snp.makeConstraints { (make) in
            make.left.equalTo(voiceButton.snp.right).offset(7)
            make.right.equalTo(emotionButton.snp.left).offset(-7)
            make.top.equalTo(self).offset(7)
            make.bottom.equalTo(self).offset(-7)
        }
        recordButton.snp.makeConstraints { (make) in
            make.left.equalTo(voiceButton.snp.right).offset(7)
            make.right.equalTo(emotionButton.snp.left).offset(-7)
            make.height.equalTo(35)
            make.centerY.equalTo(self)
        }
        // 添加上下两条线
        for i in 0..<2 {
            let splitLine = UIView()
            splitLine.backgroundColor = kSplitLineColor
            self.addSubview(splitLine)
            if i == 0 {
                splitLine.snp.makeConstraints({ (make) in
                    splitLine.snp.makeConstraints { (make) in
                        make.left.top.right.equalTo(self)
                        make.height.equalTo(0.5)
                    }
                })
            } else {
                splitLine.snp.makeConstraints({ (make) in
                    splitLine.snp.makeConstraints { (make) in
                        make.left.bottom.right.equalTo(self)
                        make.height.equalTo(0.5)
                    }
                })
            }
        }
    }
    private func updateUI() {
        
    }
    private func layoutSubview() {
        recordButtonBounds = recordButton.bounds
    }
}

// MARK:- 初始化事件
extension ChatBarView {
    private func setupEvents() {
        // 录音按钮的事件
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(voiceBtnLongTap(_:)))
        recordButton.addGestureRecognizer(longTap)
    }
    
    // 切换 录音按钮的UI
    private func replaceRecordBtnUI(isRecording: Bool, isCancel: Bool? = false) {
        let image1 = UIImage.imageWithColor(color: UIColor.hexInt(0xC6C7CB))
        let image2 = UIImage.imageWithColor(color: UIColor.hexInt(0xF3F4F8))
        if isRecording {
            recordButton.setBackgroundImage(image1, for: .normal)
            recordButton.setBackgroundImage(image2, for: .highlighted)
            recordButton.setTitle("按住 说话", for: .highlighted)
            var str = "松开 结束"
            if isCancel == true {
                str = "松开 取消"
            }
             recordButton.setTitle(str, for: .normal)
        } else {
            recordButton.setBackgroundImage(image2, for: .normal)
            recordButton.setBackgroundImage(image1, for: .highlighted)
            recordButton.setTitle("按住 说话", for: .normal)
            recordButton.setTitle("松开 结束", for: .highlighted)
        }
    }
}

// MARK:- 事件处理
extension ChatBarView {
    func resetBtnsUI()  {
        voiceButton.setImage(UIImage(named: "voice"), for: .normal)
        voiceButton.setImage(UIImage(named: "voice_HL"), for: .highlighted)
        
        emotionButton.setImage(UIImage(named: "face"), for: .normal)
        emotionButton.setImage(UIImage(named: "face_HL"), for: .highlighted)
        
        moreButton.setImage(UIImage(named: "more_ios"), for: .normal)
        moreButton.setImage(UIImage(named: "more_ios_HL"), for: .highlighted)
        
        // 时刻修改barView的高度
        self.textViewDidChange(inputTextView)
    }
    
    
    @objc func voiceBtnLongTap(_ longTap: UILongPressGestureRecognizer) {

        if longTap.state == .began {    // 长按开始
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapBegan"), object: longTap)
            self.replaceRecordBtnUI(isRecording: true)
        } else if longTap.state == .changed {   // 长按平移
            let point = longTap.location(in: recordButton)
            let isContain = recordButtonBounds.contains(point)
            if isContain == false {
                // 取消
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapCancelled"), object: longTap)
                self.replaceRecordBtnUI(isRecording: true, isCancel: true)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapChanged"), object: longTap)
                self.replaceRecordBtnUI(isRecording: true)
            }
        } else if longTap.state == .ended { // 长按结束
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kNoteChatBarRecordBtnLongTapEnded"), object: longTap)
            self.replaceRecordBtnUI(isRecording: false)
        }
    }
    
    @objc func voiceBtnClick(_ btn: UIButton) {
        print("voiceBtnClick")
        resetBtnsUI()
        if keyboardType == .voice { // 正在显示语音
            keyboardType = .text
            
            inputTextView.isHidden = false
            recordButton.isHidden = true
            inputTextView.becomeFirstResponder()
            
        } else {
            keyboardType = .voice
            
            inputTextView.isHidden = true
            recordButton.isHidden = false
            inputTextView.resignFirstResponder()
            
            voiceButton.setImage(UIImage(named: "keyboard"), for: .normal)
            voiceButton.setImage(UIImage(named: "keyboard_HL"), for: .highlighted)
            
            // 调用代理方法
            delegate?.chatBarShowVoice()
            // 改变键盘高度为正常
            delegate?.chatBarUpdateHeight(height: kChatBarOriginHeight)
        }
    }
    @objc func emotionBtnClick(_ btn: UIButton) {
        print("emotionBtnClick")
        resetBtnsUI()
        if keyboardType == .emotion { // 正在显示表情键盘
            keyboardType = .text
            inputTextView.isHidden = false
            recordButton.isHidden = true
            inputTextView.becomeFirstResponder()
        } else {
            if keyboardType == .voice {
                recordButton.isHidden = true
                inputTextView.isHidden = false
                // textViewDidChange
            } else if keyboardType == .text {
                inputTextView.resignFirstResponder()
            }
            
            keyboardType = .emotion
            
            emotionButton.setImage(UIImage(named: "keyboard"), for: .normal)
            emotionButton.setImage(UIImage(named: "keyboard_HL"), for: .highlighted)
            
            // 调用代理方法
            delegate?.chatBarShowEmotionKeyboard()
        }
        
    }
    @objc func moreBtnClick(_ btn: UIButton) {
        print("moreBtnClick")
        resetBtnsUI()
        if keyboardType == .more { // 正在显示更多键盘
            keyboardType = .text
            inputTextView.isHidden = false
            recordButton.isHidden = true
            inputTextView.becomeFirstResponder()
        } else {
            if keyboardType == .voice {
                recordButton.isHidden = true
                inputTextView.isHidden = false
                // textViewDidChange
            } else if keyboardType == .text {
                inputTextView.resignFirstResponder()
            }
            
            keyboardType = .more
            
            moreButton.setImage(UIImage(named: "more_ios"), for: .normal)
            moreButton.setImage(UIImage(named: "more_ios_HL"), for: .highlighted)
            
            // 调用代理方法
            delegate?.chatBarShowMoreKeyboard()
        }
    }
}


extension ChatBarView : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        resetBtnsUI()
        
        keyboardType = .text
        
        // 调用代理方法
        delegate?.chatBarShowTextKeyboard()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        var height = textView.sizeThatFits(CGSize(width: textView.mg_width, height: CGFloat(Float.greatestFiniteMagnitude))).height
        height = height > kChatBarTextViewHeight ? height : kChatBarTextViewHeight
        height = height < kChatBarTextViewMaxHeight ? height : textView.mg_height
        inputTextViewCurHeight = height + kChatBarOriginHeight - kChatBarTextViewHeight
        if inputTextViewCurHeight != textView.mg_height {
            UIView.animate(withDuration: 0.05, animations: {
                // 调用代理方法
                self.delegate?.chatBarUpdateHeight(height: self.inputTextViewCurHeight)
            })
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            print("发送")
            delegate?.chatBarSendMessage()
            return false
        }
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("文字改变")
        inputTextView.scrollRangeToVisible(NSMakeRange(inputTextView.text.count, 1))
        
        self.textViewDidChange(inputTextView)
    }
}

