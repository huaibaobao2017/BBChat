//
//  FriendViewModel.swift
//  BBChat
//
//  Created by bb on 2017/12/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

// 单例
struct ContactManager {
    static let shared = ContactManager()
    private init(){}
}

extension ContactManager {
    
    /// 获取好友列表
    
    // 从服务器获取好友列表
    func getContactsFromServer(successCallback: @escaping (_ contacts: [String])->()) {
        EMClient.shared().contactManager.getContactsFromServer { (contacts, error) in
            guard let error = error else {
                guard let contacts = contacts as? [String] else { return }
                print("从服务器获取好友列表\(contacts)")
                successCallback(contacts)
                return
            }
            guard let desc = error.errorDescription else { return }
            print("从服务器获取好友列表失败\(desc))")
        }
    }
    
    // 从数据库获取好友列表
    func getContactsFromLocal(successCallback: @escaping (_ contacts: [String])->()) {
        guard let contacts = EMClient.shared().contactManager.getContacts() as? [String] else {
            print("从本地获取好友列表失败")
            self.getContactsFromServer(successCallback: { contacts in
                successCallback(contacts)
            })
            return
        }
        // 获取到的数组为空
        if contacts.isEmpty {
            self.getContactsFromServer(successCallback: { contacts in
                successCallback(contacts)
            })
        } else {
            print("从本地获取好友列表\(contacts)")
            successCallback(contacts)
        }
    }
    
    
    /// 好友申请
    
    // 发送加好友申请
    func addContact(chatId: String, message: String? = nil) {
        EMClient.shared().contactManager.addContact(chatId, message: message) { (chatId, error) in
            if error == nil {
                print("给用户\(chatId)发送加好友申请成功")
            } else {
                print("发送加好友申请失败\(error?.errorDescription)")
            }
        }
    }
    
    // 删除好友
    func deleteContact(chatId: String) {
        EMClient.shared().contactManager.deleteContact(chatId, isDeleteConversation: true) { (chatId, error) in
            if error == nil {
                print("删除\(chatId)用户成功")
            } else {
                print("删除失败")
            }
        }
    }
    
    // 同意加好友申请
    func acceptInvitation(chatId: String) {
        EMClient.shared().contactManager.approveFriendRequest(fromUser: chatId) { (chatId, error) in
            if error == nil {
                print("同意成功")
                NOTIFY_POST(name: KContactListDidUpdateNotification, object: "didApprove", userInfo: ["chatId": chatId ?? ""])
            } else {
                print("同意失败")
            }
        }
    }
    
    // 拒绝加好友申请
    func declineInvitation(chatId: String) {
        EMClient.shared().contactManager.declineFriendRequest(fromUser: chatId) { (chatId, error) in
            if error == nil {
                print("拒绝成功")
            } else {
                print("拒绝失败")
            }
        }
    }
    
    
    /// 黑名单
    
    // 从服务器获取黑名单列表
    func getBlackListFromServer() {
        EMClient.shared().contactManager.getBlackListFromServer { (blacklist, error) in
            if error == nil {
                print("获取黑名单列表成功,共\(String(describing: blacklist?.count))条")
            } else {
                print("获取黑名单列表失败")
            }
        }
    }
    
    // 从数据库获取黑名单列表
    func getBlackListFromLocal() {
        let blacklist = EMClient.shared().contactManager.getBlackList()
        if blacklist != nil {
            print("获取黑名单列表成功,共\(String(describing: blacklist?.count))条")
        } else {
            print("获取黑名单列表失败")
        }
    }
    
    // 将xxx加入黑名单
    func addToBlackList(chatId: String) {
        EMClient.shared().contactManager.addUser(toBlackList: chatId) { (chatId, error) in
            if error == nil {
                print("加入黑名单成功")
            } else {
                print("加入黑名单失败")
            }
        }
    }
    
    // 将xxx移除黑名单
    func removeFromBlackList(chatId: String) {
        EMClient.shared().contactManager.removeUser(fromBlackList: chatId) { (chatId, error) in
            if error == nil {
                print("移除黑名单成功")
            } else {
                print("移除黑名单失败")
            }
        }
    }
     
}
