//
//  ContactSearchResultsViewModel.swift
//  BBChat
//
//  Created by bb on 2018/1/5.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Contacts
import Hyphenate

class ContactSearchResultsViewModel {
    // 当前用户的环信ID
    let currentUsername = EMClient.shared().currentUsername
    lazy var text = ""
    lazy var phoneContacts = [PhoneContact]()
    weak var controller: UIViewController?
}

extension ContactSearchResultsViewModel {
    
    /// 选择联系人控制器跳转逻辑
    
    // push 控制器
    func openViewController(indexPath: IndexPath, contacts: [PhoneContact]) {
        guard let chatId = self.chatId(indexPath: indexPath, contacts: contacts) else { return }
        // 点击“推荐搜索” 查询用户
        getUserInfo(chatId: chatId)
    }
    
    // 获取搜索id
    private func chatId(indexPath: IndexPath, contacts: [PhoneContact]) -> String? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return self.text
            default:
                return nil
            }
        default:
            return contacts[indexPath.row].phoneNumber
        }
    }
    
    
    // 实时搜索／确认搜索
    func searchContact(n: Notification, callback:(String, [PhoneContact]?)->()) {
        guard let userInfo = n.userInfo as? [String: Any] else { return }
        guard let text = userInfo["text"] as? String else { return }
        guard let isUpdating = userInfo["isUpdating"] as? Bool else { return }
        self.text = text
        if isUpdating == true {
            recommendSearch(text: text, callback: callback)
        } else {
            comfirmSearch(text: text, callback: callback)
        }
    }
    
    // 实时搜索，手机联系人
    private func recommendSearch(text: String, callback:(String, [PhoneContact]?)->()) {
        let contacts = self.phoneContacts.filter { (phoneContact) -> Bool in
            return phoneContact.phoneNumber.contains(text)
        }
        callback(text, contacts)
    }
    
    // 确认搜索，搜索结果
    private func comfirmSearch(text: String, callback:(String, [PhoneContact]?)->()) {
        // enter 搜索  查询用户
        getUserInfo(chatId: text)
        callback(text, nil)
    }
    
    // 获取手机通讯录联系人[姓名／手机号码]
    func loadContactsData() {
        // 获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        // 判断当前授权状态
        guard status == .authorized else { return }
        // 创建通讯录对象
        let store = CNContactStore()
        // 获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey]
        // 创建请求对象
        // 需要传入一个(keysToFetch: [CNKeyDescriptor])
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        // 遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                //获取姓名
                let name = "\(contact.familyName)\(contact.givenName)"
                //获取电话号码
                for phone in contact.phoneNumbers {
                    let phoneNumber = phone.value.stringValue.replace("-", with: "").replace("+86", with: "").trim()
                    if phoneNumber.isPhoneNumber == true {
                        let dict = ["name": name, "phoneNumber": phoneNumber]
                        self.phoneContacts.append(PhoneContact(dict: dict))
                    }
                }
            })
        } catch {
            print(error)
        }
    }
    
    /// 根据userid获取用户信息
    func getUserInfo(chatId: String) {
        if currentUsername == chatId {
            MGKeyController?.showHint(hint: "您不能添加自己为好友 ")
            return
        }
        /// 查询云端用户信息
        ContactWebManager.shared.getContactFromServer(chatId: chatId, callback: { (contact, error) in
            if let contact = contact {
                NOTIFY_POST(name: KContactInfoDidUpdateNotification, userInfo: ["contact": contact])
            } else {
                MGKeyController?.showHint(hint: "该用户不存在")
            }
        })

    }
    
}
