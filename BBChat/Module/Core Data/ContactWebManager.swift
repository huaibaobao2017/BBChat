//
//  ContactWebManager.swift
//  BBWB
//
//  Created by bb on 2018/4/23.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import LeanCloud

class ContactWebManager: NSObject {
    /// 单例
    static let shared = ContactWebManager()
    private override init() {}
    
    let user = UserDefaults.standard
    

    /// 从本地获取联系人列表（离线）
    func loadContactsFormCache(chatIds: [String]) -> [Contact] {
        var array = [Contact]()
        for chatId in chatIds {
            guard let data = self.user.object(forKey: chatId) as? Data else {
                print("chatId:\(chatId) 本地未缓存")
                loadContactsFormServer(chatIds: chatIds)
                return array
            }
            guard let contact = NSKeyedUnarchiver.unarchiveObject(with: data) as? Contact else { continue }
            array.append(contact)
        }
        if array.isEmpty {
            loadContactsFormServer(chatIds: chatIds)
            return array
        }
        print("从本地获取到 \(array.count) 条数据")
        return array
    }
    
    /// 从云端获取联系人列表（在线）
    func loadContactsFormServer(chatIds: [String]) {
        // 无缓存
        var cql = "select * from Contact where chatId = ?"
        if chatIds.isEmpty { return }
        for _ in 0..<chatIds.count - 1 {
            cql += " or chatId = ?"
        }
        LCCQLClient.execute(cql, parameters: chatIds) { result in
            switch result {
            case .success(let result):
                guard let contacts = result.objects as? [Contact] else { return }
                print("从网络获取到 \(contacts.count) 条数据")
                DispatchQueue.concurrentPerform(iterations: contacts.count) { (index) in
                    let contact = contacts[index]
                    let data = NSKeyedArchiver.archivedData(withRootObject: contact)
                    self.user.set(data, forKey: contact.chatId.stringValue ?? "")
                    print("\(contact.chatId.stringValue ?? "")--写入完成")
                }
                self.user.synchronize()
                NOTIFY_POST(name: KContactInfoDidUpdateNotification)
            case .failure(let error):
                print(error)
            }
        }
    }
    

    /// 从本地获取联系人详细信息（离线）
    func getContactFromCache(chatId: String) -> Contact? {
        guard let data = self.user.object(forKey: chatId) as? Data else {
            print("\(chatId)--本地没有缓存")
            getContactFromServer(chatId: chatId)
            return nil
        }
        guard let contact = NSKeyedUnarchiver.unarchiveObject(with: data) as? Contact else {
            print("\(chatId)--解归档模型失败")
            getContactFromServer(chatId: chatId)
            return nil
        }
        return contact
    }
    
    
    /// 从云端获取联系人详细信息（在线）
    func getContactFromServer(chatId: String) {
        let query = LCQuery(className: "Contact")
        query.whereKey("chatId", .equalTo(chatId))
        query.getFirst { (result) in
            switch result {
            case .success(let contact):
                // TODO: -修改自定义
                guard let contact = contact as? Contact else { return }
                let data = NSKeyedArchiver.archivedData(withRootObject: contact)
                self.user.set(data, forKey: chatId)
                print("\(chatId)--写入完成")
                NOTIFY_POST(name: KContactInfoDidUpdateNotification)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

    /// 从云端获取联系人详细信息（在线）
    func getContactFromServer(chatId: String, callback:@escaping (Contact?, Error?)->()) {
        let query = LCQuery(className: "Contact")
        query.whereKey("chatId", .equalTo(chatId))
        query.getFirst { (result) in
            switch result {
            case .success(let contact):
                callback(contact as? Contact, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    
    
    /// 根据环信id 创建lc 用户（在线）
    private func creatContact(chatId: String) {
        let query = LCQuery(className: "Contact")
        query.whereKey("chatId", .equalTo(chatId))
        query.getFirst { (result) in
            switch result {
            case .success:
                print("用户已存在")
                return
            case .failure:
                print("用户不存在，开始创建新用户")
                let contact = LCObject(className: "Contact")
                contact.set("chatId", value: chatId)
                contact.save({ (r) in
                    switch r {
                    case .success:
                        print("创建新用户成功")
                    case .failure(let error):
                        print("创建新用户失败：\(error)")
                    }
                })
            }
        }
    }
    

}
