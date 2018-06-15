//
//  UserDefaultsManager.swift
//  BBChat
//
//  Created by bb on 2018/5/29.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

struct UserDefaultsManager {
    private let current = EMClient.shared().currentUsername ?? ""
    static let shared = UserDefaultsManager()
    private init(){}
}

extension UserDefaultsManager {
    
    // 设置 消息 badgeValue
    func saveSessionMessageCount(count: Int) {
        UserDefaults.standard.set(count, forKey: "unreadmessage_\(current)")
    }
    // 保存好友请求
    func saveContactRequest(contact: Contact, message: String?) {
        let data = NSKeyedArchiver.archivedData(withRootObject: contact)
        let dict: [String: Any] = ["data": data, "message": (message ?? ""), "date": Date.systemDate]
        guard var request = UserDefaults.standard.array(forKey: "newfriend_\(current)") as? [[String: Any]] else {
            // 本地不存在好友请求
            var arr = [[String: Any]]()
            arr.append(dict)
            UserDefaults.standard.set(arr, forKey: "newfriend_\(current)")
            UserDefaults.standard.synchronize()
            return
        }
        // 过滤之前的请求
        request = request.filter { (d) -> Bool in
            guard let hdata = d["data"] as? Data else { return false }
            return hdata != data
        }
        request.append(dict)
        UserDefaults.standard.set(request, forKey: "newfriend_\(current)")
        UserDefaults.standard.synchronize()
    }
}
