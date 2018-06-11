//
//  AddContactViewModel.swift
//  BBChat
//
//  Created by bb on 2018/1/5.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class AddContactViewModel {
    weak var controller: UIViewController?
}

extension AddContactViewModel {
    
    // 搜索联系人，发送通知
    func searchContact(text: String?, isUpdating: Bool) {
        guard let text = text else { return }
        if text == "" { return }
        NOTIFY_POST(name: KSearchContactNotification, userInfo: ["text": text, "isUpdating": isUpdating])
    }
    
    /// 搜索联系人成功
    func getContactProfile(note: Notification) {
        guard let userInfo = note.userInfo as? [String: Contact] else { return }
        guard let contact = userInfo["contact"] else { return }
        let vc = ProfileViewController()
        vc.contact = contact
        self.controller?.navigationController?.pushViewController(vc, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    /// 添加朋友控制器跳转逻辑
    
    // push 控制器
    func openViewController(indexPath: IndexPath) {
        guard let vc = controller(indexPath: indexPath) else { return }
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return UIViewController() // 雷达加好友
            case 1:
                return UIViewController() // 面对面建群
            case 2:
                return UIViewController() // 扫一扫
            case 3:
                return UIViewController() // 手机联系人
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
}
