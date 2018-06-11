//
//  MessageManager.swift
//  BBChat
//
//  Created by bb on 2017/12/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

// 单例
struct MessageManager {
    let currentUsername = EMClient.shared().currentUsername
    static let shared = MessageManager()
    private init(){}
}

extension MessageManager {
    
    // 根据会话类型，确定消息类型
    func chatType(conversation: EMConversation) -> EMChatType {
        switch conversation.type {
        // 群聊
        case EMConversationTypeGroupChat:
            return EMChatTypeGroupChat
        // 聊天室
        case EMConversationTypeChatRoom:
            return EMChatTypeChatRoom
        default:
            // 单聊
            return EMChatTypeChat
        }
    }
    
    // 发送消息
    func sendMessage(message: EMMessage) {
        EMClient.shared().chatManager.send(message, progress: nil) { (message, error) in
            if error == nil {
                print("发送消息成功！\(String(describing: message?.body))")
            } else {
                print(error?.errorDescription)
            }
        }
    }
    
    // 系统消息
    func groupSystemMessage(text: String, group: EMGroup?) -> EMMessage? {
        guard let group = group else { return nil }
        guard let groupId = group.groupId else { return nil }
        let body = EMTextMessageBody(text: text)
        let message = EMMessage(conversationID: groupId, from: currentUsername, to: groupId, body: body, ext: nil)
        message?.chatType = EMChatTypeGroupChat
        // 插入消息到会话
        insertMessage(message: message, type: EMConversationTypeGroupChat)
        return message
    }
    
    // 文本消息
    func textMessage(text: String, conversation: EMConversation?) -> EMMessage? {
        guard let conversation = conversation else { return nil }
        guard let conversationId = conversation.conversationId else { return nil }
        let body = EMTextMessageBody(text: text)
        let message = EMMessage(conversationID: conversationId, from: currentUsername, to: conversationId, body: body, ext: nil)
        message?.chatType = chatType(conversation: conversation)
        // 插入消息到会话
        insertMessage(message: message, type: conversation.type)
        return message
    }
    
    // 其他消息
    
    
    
    // 插入消息到所在的EMConversation DB中
    func insertMessage(message: EMMessage?, type: EMConversationType) {
        guard let message = message else { return }
        let conversation = EMClient.shared().chatManager.getConversation(message.conversationId, type: type, createIfNotExist: true)
        conversation?.insert(message, error: nil)
        // 更新消息到 DB
        updateMessage(message: message)
    }
    
    // 更新消息到 DB
    func updateMessage(message: EMMessage?) {
        EMClient.shared().chatManager.update(message) { (aMessage, error) in
            guard let error = error else {
                print("更新消息成功，新消息为\(String(describing: aMessage))")
                return
            }
            guard let desc = error.errorDescription else { return }
            print("更新消息失败\(desc)")
        }
    }
    
}
