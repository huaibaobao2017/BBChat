//
//  ContactHelper.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

// 单例
class ContactHelper {
    lazy var contacts = [Contact]()
    lazy var indexTitles = [String]()
    static let shared = ContactHelper()
    private init(){}
    
    let user = UserDefaults.standard
}

extension ContactHelper {
    
    /// 联系人列表处理逻辑
    
    // 根据userId创建contact模型(已按 A -> Z 排序)
    func sortedContacts(contacts: [Contact]) -> [SortedContact] {
        self.contacts = contacts
        let sorted = contacts.sorted { (a, b) -> Bool in
            return a.firstLetter.stringValue ?? "" < b.firstLetter.stringValue ?? ""
        }
        return divide(contacts: sorted)
    }

    // 拼音分组
    private func divide(contacts: [Contact]) -> [SortedContact] {
        var sortedContact = SortedContact()
        var sortedContacts = [SortedContact]()
        var tempString = ""
        if !indexTitles.isEmpty {
            indexTitles.removeAll()
        }
        indexTitles.append(UITableViewIndexSearch)
        // 遍历
        for contact in contacts {
            let firstLetter = contact.firstLetter.stringValue ?? ""
            // 不同
            if tempString != firstLetter {
                tempString = firstLetter
                sortedContact = SortedContact()
                sortedContact.firstLetter = tempString
                // 分组country
                sortedContact.contacts.append(contact)
                // 分组好的sortedCountry
                sortedContacts.append(sortedContact)
                // 索引
                indexTitles.append(tempString)
            } else {
                // 相同
                sortedContact.firstLetter = firstLetter
                sortedContact.contacts.append(contact)
            }
        }
        return sortedContacts
    }
    
    
    // 检测联系人是否为好友
    func isFriend(contact: Contact) -> Bool {
        return contacts.contains(contact)
    }
}
