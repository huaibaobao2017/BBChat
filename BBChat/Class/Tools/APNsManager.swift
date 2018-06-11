//
//  APNsManager.swift
//  BBChat
//
//  Created by bb on 2017/12/30.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import UserNotifications
import Hyphenate

// 单例
struct APNsManager {
    static let shared = APNsManager()
    private init(){}
}

extension APNsManager {
    
    // 获取全局 APNs 配置
    func getPushNotificationOptionsFromServer() {
        EMClient.shared().getPushNotificationOptionsFromServer { (options, error) in
            if error == nil {
                print("获取全局 APNs 配置 成功")
                guard let options = options else { return }
                options.displayStyle = EMPushDisplayStyleMessageSummary
                options.noDisturbStatus = EMPushNoDisturbStatusClose
                EMClient.shared().updatePushNotificationOptionsToServer { (error) in
                    if error == nil {
                        print("更新推送设置到服务器成功")
                    }
                }
            } else {
                print("获取全局 APNs 配置 失败")
            }
        }
    }
    
    // 更新推送昵称
    func updatePushNotifiationDisplayName() {
        guard let currentUsername = EMClient.shared().currentUsername else { return }
        let nickName = MessageHelper.shared.nickName(chatId: currentUsername)
        EMClient.shared().updatePushNotifiationDisplayName(nickName) { (displayName, error) in
            if error == nil {
                print("更新推送昵称成功")
            } else {
                print("更新推送昵称失败")
            }
        }
    }
    
    // APNs本地通知
    func apnsLocalMessage(message: EMMessage) {
        let state = UIApplication.shared.applicationState
        // App在后台
        if state == .background {
            //发送本地推送
            if #available(iOS 10.0, *) { // ios 10
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                let content = UNMutableNotificationContent()
                content.sound = UNNotificationSound.default()
                content.title = MessageHelper.shared.nickName(message: message) ?? "" // 发送者
                content.body = MessageHelper.shared.lastestMessageContent(message: message) ?? ""
                let request = UNNotificationRequest(identifier: message.messageId, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            } else {
                let notification = UILocalNotification()
                notification.fireDate = Date()
                notification.alertTitle = MessageHelper.shared.nickName(message: message) // 发送者
                notification.alertBody = MessageHelper.shared.lastestMessageContent(message: message)
                notification.alertAction = "Open"
                notification.timeZone = .autoupdatingCurrent
                notification.soundName = UILocalNotificationDefaultSoundName
                UIApplication.shared.scheduleLocalNotification(notification)
            }
        }
    }
    
}
