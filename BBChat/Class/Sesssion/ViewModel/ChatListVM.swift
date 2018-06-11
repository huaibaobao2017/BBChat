//
//  ChatListVM.swift
//  BBChat
//
//  Created by bb on 2018/4/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class ChatListVM: NSObject {
    
    var conversation: EMConversation?
    
    var iconUrl: URL?
    
    var title: String?
    
    var message: String?
    
    var time: String?
    
    var unreadCount: String?
    
    ///
    var contact: Contact?
    
    init(conversation: EMConversation) {
        super.init()
        
        ///
        self.contact = ContactWebManager.shared.getContactFromCache(chatId: conversation.conversationId)
        
        self.conversation = conversation
        
        iconUrl = getConversationImageUrl(conversation: conversation)
        
        title = getConversationName(conversation: conversation)
        
        message = getLatestMessageContent(conversation: conversation)
        
        time = getLatestMessageTime(conversation: conversation)
        
        unreadCount = getUnreadMessagesCount(conversation: conversation)
    }
    
    
    // 根据会话id，获取会话对方的头像
    private func getConversationImageUrl(conversation: EMConversation) -> URL? {
        switch conversation.type {
        case EMConversationTypeChat:
            // 单聊
            return URL(string: contact?.avatarUrl.stringValue ?? "")
        case EMConversationTypeGroupChat:
            // 组群
            return nil
        case EMConversationTypeChatRoom:
            // 聊天室
            return nil
        default:
            return nil
        }
    }
    
    // 根据会话类型，分别处理
    private func getConversationName(conversation: EMConversation) -> String? {
        switch conversation.type {
        case EMConversationTypeChat:
            // 单聊
            return contact?.nickName.stringValue
        case EMConversationTypeGroupChat:
            // 组群
            return "群组名称"
        case EMConversationTypeChatRoom:
            // 聊天室
            return nil
        default:
            return nil
        }
    }
    
    // 根据消息类型，分别处理
    private func getLatestMessageContent(conversation: EMConversation) -> String? {
        guard let latestMessage = conversation.latestMessage else { return nil }
        return MessageHelper.shared.lastestMessageContent(message: latestMessage)
    }
    
    // 发送／接收 最新消息时间
    func getLatestMessageTime(conversation: EMConversation) -> String? {
        guard let latestMessage = conversation.latestMessage else { return nil }
        let localTime = (latestMessage.localTime / 1000).getTimeString()
        return localTime
    }
    
    // 未读消息 处理
    private func getUnreadMessagesCount(conversation: EMConversation) -> String? {
        let unreadMessagesCount = conversation.unreadMessagesCount
        switch unreadMessagesCount {
        case 0:
            return nil
        case 1...99:
            return "\(unreadMessagesCount)"
        default:
            return "99+"
        }
    }
    
    /// 会话列表控制器跳转逻辑
    
    // push 控制器
    func openViewController(from: UIViewController) {
        HistoryHelper.shared.loadHistoryMessage(conversation: conversation, isFirstPage: true) { (messages) in
            guard let vc = self.controller(conversation: self.conversation) else { return }
            if let messages = messages {
                vc.messages = messages
            }
            vc.title = self.title
            from.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 简单跳转路由
    private func controller(conversation: EMConversation?) -> ChatViewController? {
        guard let conversation = conversation else { return nil }
        switch conversation.type {
        case EMConversationTypeChat, EMConversationTypeGroupChat, EMConversationTypeChatRoom:
            return ChatViewController(conversationId: conversation.conversationId, conversationType: conversation.type)
        default:
            return nil
        }
    }

}
