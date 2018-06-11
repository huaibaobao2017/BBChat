//
//  AppDelegate+Extension.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate
import UserNotifications
import IQKeyboardManagerSwift

@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    //iOS10新增：处理前台收到通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent")
        //        let request = notification.request
        //        if let trigger = request.trigger {
        //            if trigger.isKind(of: UNPushNotificationTrigger.self) {
        //                let userInfo = request.content.userInfo
        //                print("willPresent获取到的数据\(userInfo)")
        //            }
        //        }
        completionHandler([.badge, .alert, .sound])
    }
    //iOS10新增：处理后台点击通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive")
        //        let userInfo = response.notification.request.content.userInfo
        //        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
        //
        //        }
        completionHandler()
    }
}

// app生命周期
extension AppDelegate {
    // APP进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        EMClient.shared().applicationDidEnterBackground(application)
    }
    // APP将要从后台返回
    func applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application)
    }
    // 将得到的deviceToken传给SDK
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DispatchQueue.global().async {
            print("注册deviceToken成功\(deviceToken)")
            EMClient.shared().bindDeviceToken(deviceToken)
        }
    }
    // 注册deviceToken失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("注册deviceToken失败\(error)")
    }
    // 实现iOS8和iOS9处理通知方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("收到新消息Active\(userInfo)")
        if application.applicationState == .active {
            // 代表从前台接受消息app
        }else{
            // 代表从后台接受消息后进入app
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        completionHandler(.newData)
    }
    
}

// 其他逻辑
extension AppDelegate {
    // 延迟2s启动执行
    func asyncAfter(application: UIApplication){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // 注册远程通知
            self.registerAppNotificationSettings()
            // 键盘管理
            self.keyboardManager()
        }
    }
    
    // 注册远程通知
    private func registerAppNotificationSettings() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { (granted, error) in
                if error == nil {
                    print("request authorization succeeded!")
                }
            })
        } else { //iOS8,iOS9注册通知
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        // 注册APNS
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    // 键盘管理
    private func keyboardManager() {
        let manager = IQKeyboardManager.sharedManager()
        manager.enableAutoToolbar = false
        manager.shouldResignOnTouchOutside = true
    }
    
    // 更新推送昵称
    @objc func updatePushNotifiationDisplayName() {
        MGAPNs.updatePushNotifiationDisplayName()
    }
    
    // 添加代理
    func addDelegate() {
        // app逻辑代理
        EMClient.shared().add(self, delegateQueue: nil)
        // contactManager代理
        EMClient.shared().contactManager.add(self, delegateQueue: nil)
        // chatManager代理
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        // groupManager代理
        EMClient.shared().groupManager.add(self, delegateQueue: nil)
    }
    // 移除代理
    func removeDelegate() {
        EMClient.shared().removeDelegate(self)
        EMClient.shared().contactManager.removeDelegate(self)
        EMClient.shared().chatManager.remove(self)
        EMClient.shared().groupManager.removeDelegate(self)
    }
    
}
