//
//  ChatBarViewController.swift
//  ChatKeyBoard
//
//  Created by bb on 2018/1/26.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

// MARK:- 实现代理方法
// MARK:- ChatBarViewDelegate
extension ChatBarViewController: ChatBarViewDelegate {
    
    func chatBarUpdateHeight(height: CGFloat) {
        chatBarView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        delegate?.chatBarUpdateHeight(height: height)
    }
    
    func chatBarShowTextKeyboard() {
        print("普通键盘")
        keyboardType = .text
        delegate?.chatBarShowTextKeyboard()
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: keyboardFrame?.height ?? 0)
    }
    
    func chatBarShowMoreKeyboard() {
        print("更多面板")
        keyboardType = .more
        delegate?.chatBarShowMoreKeyboard()
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: kNoTextKeyboardHeight)
    }
    
    func chatBarShowEmotionKeyboard() {
        print("表情面板")
        keyboardType = .emotion
        delegate?.chatBarShowEmotionKeyboard()
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: kNoTextKeyboardHeight)
    }
    
    func chatBarShowVoice() {
        print("声音")
        keyboardType = .voice
        delegate?.chatBarShowVoice()
        delegate?.chatBarVC(chatBarVC: self, didChageChatBoxBottomDistance: 0)
    }
    
    func chatBarSendMessage() {
        print("发送信息")
        sendMessage()
    }
}

