//
//  MessageHelper.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//  此类专门用来处理各种消息

import UIKit
import Hyphenate

// 单例
struct MessageHelper {
    static let shared = MessageHelper()
    private init(){}
}

extension MessageHelper {
    
    // 处理接受到消息
    func handleReceivedMessage(aMessages: [EMMessage]) {
        for message in aMessages {
            // APNs本地通知
            MGAPNs.apnsLocalMessage(message: message)
            //
            //            let msgBody = message.body
            //            switch msgBody?.type {
            //            case EMMessageBodyTypeText?:
            //                // 收到的文字消息
            //                let textBody = msgBody as? EMTextMessageBody
            //                let text = textBody?.text
            //                print("收到的文字是 text\(text)")
            //            case EMMessageBodyTypeImage?:
            //                // 得到一个图片消息body
            //                let body = msgBody as? EMImageMessageBody
            //                print("大图remote路径\(body?.remotePath)")
            //                // 需要使用sdk提供的下载方法后才会存在
            //                print("大图local路径\(body?.secretKey)")
            //                print("大图的secret\(body?.localPath)")
            //                print("大图的W,大图的H\(body?.size.width)\(body?.size.height)")
            //                print("大图的下载状态\(body?.downloadStatus)")
            //                // 缩略图sdk会自动下载
            //                print("小图remote路径\(body?.thumbnailRemotePath)")
            //                print("小图local路径\(body?.thumbnailLocalPath)")
            //                print("小图的secret\(body?.thumbnailSecretKey)")
            //                print("小图的W,小图的H\(body?.thumbnailSize.width)\(body?.thumbnailSize.height)")
            //                print("小图的下载状态\(body?.thumbnailDownloadStatus)")
            //            case EMMessageBodyTypeLocation?:
            //                let body = msgBody as? EMLocationMessageBody
            //                print("纬度\(body?.latitude)")
            //                print("经度\(body?.longitude)")
            //                print("地址\(body?.address)")
            //            case EMMessageBodyTypeVoice?:
            //                // 音频sdk会自动下载
            //                let body = msgBody as? EMVoiceMessageBody
            //                print("音频remote路径\(body?.remotePath)")
            //                // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
            //                print("音频local路径\(body?.localPath)")
            //                print("音频的secret\(body?.secretKey)")
            //                print("音频文件大小\(body?.fileLength)")
            //                print("音频文件的下载状态\(body?.downloadStatus)")
            //                print("音频的时间长度\(body?.duration)")
            //            case EMMessageBodyTypeVideo?:
            //                 let body = msgBody as? EMVideoMessageBody
            //                 print("视频remote路径\(body?.remotePath)")
            //                 // 需要使用sdk提供的下载方法后才会存在
            //                 print("视频local路径\(body?.localPath)")
            //                 print("视频的secret\(body?.secretKey)")
            //                 print("视频文件大小\(body?.fileLength)")
            //                 print("视频文件的下载状态\(body?.downloadStatus)")
            //                 print("视频的时间长度\(body?.duration)")
            //                 print("视频的W, 视频的H\(body?.thumbnailSize.width)\(body?.thumbnailSize.height)")
            //                 // 缩略图sdk会自动下载
            //                 print("缩略图remote路径\(body?.thumbnailRemotePath)")
            //                 print("缩略图local路径\(body?.thumbnailLocalPath)")
            //                 print("缩略图的secret\(body?.thumbnailSecretKey)")
            //                 print("缩略图的下载状态\(body?.thumbnailDownloadStatus)")
            //            case EMMessageBodyTypeFile?:
            //                let body = msgBody as? EMFileMessageBody
            //                print("文件remote路径\(body?.remotePath)")
            //                // 需要使用sdk提供的下载方法后才会存在
            //                print("文件local路径\(body?.localPath)")
            //                print("文件的secret\(body?.secretKey)")
            //                print("文件的大小\(body?.fileLength)")
            //                print("文件的下载状态\(body?.downloadStatus)")
            //            default:
            //                break
            //            }
        }
    }
    
    
    private func contact(chatId: String) -> Contact? {
        return ContactWebManager.shared.getContactFromCache(chatId: chatId)
    }
    
    
    // 根据消息获取头像（会话列表/APNs通知）
    func avatarUrl(message: EMMessage) -> URL? {
        // 先从客户端本地获取对方头像
        if let contact = contact(chatId: message.from) {
            return URL(string: contact.avatarUrl.stringValue ?? "")
        } else {
            // 本地没有缓存，则从对方发送过来的消息扩展属性中获取
            // admin系统消息没有ext扩展属性
            guard let ext = message.ext else { return nil }
            guard let value = ext["avatarUrl"] else { return nil }
            guard let urlStr = value as? String else { return nil }
            return URL(string: urlStr)
        }
    }
    
    // 根据userId获取头像
    func avatarUrl(chatId: String?) -> URL? {
        guard let chatId = chatId else { return nil }
        // 客户端本地获取对方头像
        if let contact = contact(chatId: chatId) {
            return URL(string: contact.avatarUrl.stringValue ?? "")
        }
        return nil
    }
    
    // 根据消息获取昵称（会话列表/APNs通知）
    func nickName(message: EMMessage) -> String? {
        // 先从客户端本地获取对方昵称
        if let contact = contact(chatId: message.from) {
            return contact.nickName.stringValue
        } else {
            // 本地没有缓存，则从对方发送过来的消息扩展属性中获取
            // admin系统消息没有ext扩展属性
            guard let ext = message.ext else { return message.from }
            guard let value = ext["nickName"] else { return message.from }
            guard let name = value as? String else { return message.from }
            return name
        }
    }
    
    // 根据userId获取昵称
    func nickName(chatId: String?) -> String? {
        guard let chatId = chatId else { return nil }
        // 客户端本地获取对方昵称
        if let contact = contact(chatId: chatId) {
            return contact.nickName.stringValue
        }
        return nil
    }
    
    // 根据userId获取聊天号
    func chatNumber(chatId: String?) -> String? {
        guard let chatId = chatId else { return nil }
        // 客户端本地获取对方昵称
        if let contact = contact(chatId: chatId) {
            return contact.chatNumber.stringValue
        }
        return nil
    }
    
    // 最新消息内容处理（会话列表/APNs通知）
    func lastestMessageContent(message: EMMessage) -> String? {
        guard let msgBody = message.body else { return nil }
        var from: String? = nil
        if message.chatType != EMChatTypeChat {
            // 非系统消息,群聊／聊天室 显示成员昵称
            if isSystemMessage(message: message) != true {
                from = "\(nickName(message: message)): "
            } else {
                // 系统消息
                // 创建者本人
                guard let currentUsername = EMClient.shared().currentUsername else { return nil }
                if currentUsername == message.from {
                    from = "你"
                } else {
                    // 其他成员
                    from = nickName(chatId: message.from)
                }
            }
        }
        switch msgBody.type {
        case EMMessageBodyTypeText:
            guard let body = msgBody as? EMTextMessageBody else { return nil }
            guard let text = body.text else { return nil }
            return "\(from ?? "")\(text)"
        case EMMessageBodyTypeImage:
            return "\(from ?? "")[图片]"
        case EMMessageBodyTypeLocation:
            return "\(from ?? "")[位置]"
        case EMMessageBodyTypeVoice:
            return "\(from ?? "")[语音]"
        case EMMessageBodyTypeVideo:
            return "\(from ?? "")[视频]"
        case EMMessageBodyTypeFile:
            return "\(from ?? "")[文件]"
        default:
            return nil
        }
    }
    
    // 判断是否属于系统消息
    func isSystemMessage(message: EMMessage) -> Bool {
        guard let ext = message.ext else { return false }
        guard let value = ext["isSystemMessage"] else { return false }
        guard let isSystem = value as? String else { return false }
        return isSystem == "true" ? true : false
    }
    
}
