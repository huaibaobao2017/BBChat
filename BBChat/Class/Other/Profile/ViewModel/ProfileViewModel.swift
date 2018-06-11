//
//  ProfileViewModel.swift
//  BBChat
//
//  Created by bb on 2018/1/9.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ProfileViewModel {
    weak var controller: UIViewController?
}

extension ProfileViewModel {
    // 检测联系人是否为好友
    func isFriend(contact: Contact) -> Bool {
        return ContactHelper.shared.isFriend(contact: contact)
    }
    
    // 好友／陌生人 其他信息行数
    func sectionRowCount(isFriend: Bool, contact: Contact) -> Int {
        if isFriend == true {
            return 5
        } else {
            if contact.region == "" && contact.signature == "" {
                return 2
            } else if contact.region == "" || contact.signature == "" {
                return 3
            } else {
                return 4
            }
        }
    }
    
    
    func sectionRowText(isFriend: Bool, contact: Contact, indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 2:
            return "设置备注和标签"
        case 3:
            return ""
        default:
            return ""
        }
    }
    
}
