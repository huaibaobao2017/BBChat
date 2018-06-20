//
//  ContactSearchViewModel.swift
//  BBChat
//
//  Created by bb on 2018/6/20.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class ContactSearchViewModel {
    weak var controller: UIViewController?
}

extension ContactSearchViewModel {
    
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
    
}
