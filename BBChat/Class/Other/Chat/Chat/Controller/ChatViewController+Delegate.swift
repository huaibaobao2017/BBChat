//
//  ChatViewController+Delegate.swift
//  ChatKeyBoard
//
//  Created by bb on 2018/1/26.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

// MARK:- 实现代理方法
// MARK:- ChatViewControllerDelegate
extension ChatViewController: ChatBarViewControllerDelegate {
    
    /* chatBarView 代理方法 */
    func chatBarUpdateHeight(height: CGFloat) {

    }
    
    func chatBarVC(chatBarVC: ChatBarViewController, didChageChatBoxBottomDistance distance: CGFloat) {
        
        print("键盘：\(distance)")
        
        // 若 distance 为0，则不更新约束
        if chatBarVC.keyboardType != .voice && distance == 0 {
            resetChatBarFrame()
            return
        } else {
            chatMsgVC.scrollsToBottom(animated: true)
        }
        
        chatBarVC.view.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(-distance)
        })

        UIView.animate(withDuration: kKeyboardChangeFrameTime) {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.view.layoutIfNeeded()
        }
        
    }
    
    func chatBarShowTextKeyboard() {
        UIView.animate(withDuration: kKeyboardChangeFrameTime) {
            self.emotionView.alpha = 0
            self.moreView.alpha = 0
        }
    }
    func chatBarShowVoice() {
        // 暂时没用
    }
    func chatBarShowEmotionKeyboard() {
        self.emotionView.alpha = 1
        self.moreView.alpha = 1
        moreView.snp.updateConstraints { (make) in
            make.top.equalTo(self.emotionView.snp.bottom)
        }
        UIView.animate(withDuration: kKeyboardChangeFrameTime) {
            self.view.layoutIfNeeded()
        }
    }
    func chatBarShowMoreKeyboard() {
        self.emotionView.alpha = 1
        self.moreView.alpha = 1
        moreView.snp.updateConstraints { (make) in
            make.top.equalTo(self.emotionView.snp.bottom).offset(-kNoTextKeyboardHeight)
        }
        UIView.animate(withDuration: kKeyboardChangeFrameTime) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK:- LXFChatMessageControllerDelegate
extension ChatViewController: ChatMsgViewControllerDelegate {
    func chatMsgVCWillBeginDragging(chatMsgVC: ChatMsgViewController) {
        // 还原barView的位置
        print("拖拽")
        resetChatBarFrame()
    }
}
