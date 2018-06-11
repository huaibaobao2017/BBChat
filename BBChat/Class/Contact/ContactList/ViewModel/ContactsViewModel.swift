//
//  ContactsViewModel.swift
//  BBChat
//
//  Created by bb on 2018/4/24.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ContactListViewModel {
    weak var controller: UIViewController?
}

extension ContactListViewModel {
    
    /// 联系人列表控制器跳转逻辑
    
    // push 控制器
    func openViewController(indexPath: IndexPath, contacts: [SortedContact]) {
        guard let vc = self.controller(indexPath: indexPath) else { return }
        if vc.isKind(of: ProfileViewController.self) {
            let contacts = contacts[indexPath.section].contacts
            let contact = contacts[indexPath.row]
            if contact.chatId != "" {
                guard let vc = vc as? ProfileViewController else { return }
                vc.contact = contact
            }
        }
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return NewContactViewController()//NewContactViewController() // 新的朋友
            case 1:
                return ProfileViewController()//GroupListViewController() // 群聊
            case 2:
                return ProfileViewController()//UIViewController() // 标签
            default:
                return ProfileViewController()//nil
            }
        default:
            return ProfileViewController() // 联系人详细信息
        }
    }
    
}
