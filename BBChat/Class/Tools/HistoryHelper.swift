//
//  History.swift
//  BBChat
//
//  Created by bb on 2018/1/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class HistoryHelper {
    // 参考消息
    var message: EMMessage?
    // 每次加载到历史消息
    var historys: [EMMessage]?
    // 加载到总历史消息
    var messages: [EMMessage]? {
        didSet {
            /// 获取到的所有消息重新按照客户端接收时间排序
            self.messages = self.messages?.sorted(by: { (a, b) -> Bool in
                return a.localTime < b.localTime
            })
        }
    }
    static let shared = HistoryHelper()
    private init(){}
}

extension HistoryHelper {

    func loadHistoryMessage(conversation: EMConversation?, isFirstPage: Bool, success: @escaping ([EMMessage]?)->()) {
        guard let conversation = conversation else { return }
        var messageId: String?
        
        if isFirstPage {
            messageId = ""
        } else {
            let message = historys?.first
            messageId = message?.messageId
        }
        
        // 从参考消息往前加载数据
        conversation.loadMessagesStart(fromId: messageId, count: 15, searchDirection: EMMessageSearchDirectionUp) { (messages, error) in
            if error == nil {
                guard let messages = messages as? [EMMessage] else {
                    success(nil)
                    return
                }
                self.historys = messages
                if isFirstPage {
                    self.messages = messages
                } else {
                    self.messages! += messages
                }
            
                success(self.historys)
            } else {
                print("失败\(String(describing: error))")
                success(nil)
            }
        }
    }
    
}
