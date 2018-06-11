//
//  Conversation.swift
//  BBChat
//
//  Created by bb on 2017/12/18.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

struct ConversationManager {
    static let shared = ConversationManager()
    private init(){}
}

extension ConversationManager {
    
    // 新建/获取一个会话
    func getConversation(conversationId: String, type: EMConversationType) -> EMConversation? {
        let conversation = EMClient.shared().chatManager.getConversation(conversationId, type: type, createIfNotExist: true)
        return conversation
    }
    
    // 删除单个会话
    func deleteConversation(conversationId: String, successCallback: @escaping ()->()) {
        EMClient.shared().chatManager.deleteConversation(conversationId, isDeleteMessages: true) { (aConversationId, error) in
            guard let error = error else {
                print("删除会话成功")
                successCallback()
                return
            }
            guard let desc = error.errorDescription else { return }
            print("删除会话失败\(desc)")
        }
    }
    
    // 批量删除会话
    func deleteConversations(conversations: [EMConversation], successCallback: @escaping ()->()) {
        EMClient.shared().chatManager.deleteConversations(conversations, isDeleteMessages: true) { (error) in
            guard let error = error else {
                print("批量删除会话成功")
                successCallback()
                return
            }
            guard let desc = error.errorDescription else { return }
            print("批量删除会话失败\(desc)")
        }
    }
    
    // 获取所有会话(内存中有则从内存中取，没有则从db中取)
    var conversations: [EMConversation] {
        guard let conversations = EMClient.shared().chatManager.getAllConversations() as? [EMConversation] else { return [EMConversation]() }
        // 根据客户端接收到消息到时间降序排列
        return conversations.sorted { (a, b) -> Bool in
            // 群聊可能存在无消息都情况
            if let aM = a.latestMessage, let bM = b.latestMessage {
                return aM.localTime > bM.localTime
            } else {
                return true
            }
        }
    }
    
}
