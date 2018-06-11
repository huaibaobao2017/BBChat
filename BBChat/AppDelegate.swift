//
//  AppDelegate.swift
//  BBChat
//
//  Created by bb on 2017/12/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate
import LeanCloud
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 1.设置主窗口
        setupKeyWindow()
        // 2. 延迟2s启动执行
        asyncAfter(application: application)
        return true
    }
    
    deinit {
        removeDelegate()
    }
    
}

// app逻辑在这里处理
extension AppDelegate {
    // 设置主窗口
    private func setupKeyWindow() {
        // 环信初始化
        initHyphenate()
        // 环信 用户是否自动登录
        let isAutoLogin = EMClient.shared().options.isAutoLogin
        // 延时1s显示
        Thread.sleep(forTimeInterval: 1.0)
        
        BaseNavigationController.initializeOnceMethod()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        if (isAutoLogin == false) {
            let nvc = UINavigationController(rootViewController: LoginViewController())
            self.window?.rootViewController = nvc
        } else {
            self.window?.rootViewController = MainTabBarViewController()
        }
        self.window?.makeKeyAndVisible()
        
        // leancloud初始化
        initLeanCloud()
    }

}

// 专门处理环信初始化
extension AppDelegate {
    // 初始化环信
    func initHyphenate() {
        let options = EMOptions.init(appkey: hyphenateAppKey)
        options?.apnsCertName = "APNs-dev"
        options?.enableConsoleLog = false
        options?.isDeleteMessagesWhenExitGroup = false
        options?.isDeleteMessagesWhenExitChatRoom = false
        options?.enableDeliveryAck = true
        options?.logLevel = EMLogLevelError
        options?.isAutoLogin = true
        let error = EMClient.shared().initializeSDK(with: options)
        if error == nil {
            print("初始化成功")
            // 添加代理
            addDelegate()
        } else {
            print("初始化失败")
        }
    }
}

// 专门处理环信客户端业务逻辑代理
extension AppDelegate: EMClientDelegate {
    // 自动登录返回结果
    func autoLoginDidCompleteWithError(_ aError: EMError!) {
        if aError == nil {
            print("自动登录完成!")
            // 配置离线推送
            MGAPNs.getPushNotificationOptionsFromServer()
            NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updatePushNotifiationDisplayName))
        }
    }
    // SDK连接服务器的状态变化时会接收到该回调
    func connectionStateDidChange(_ aConnectionState: EMConnectionState) {
        switch aConnectionState.rawValue {
        case 0:
            print("已连接网络")
        default:
            print("无网络")
        }
    }
    // 当前登录账号在其它设备登录时会接收到该回调
    func userAccountDidLoginFromOtherDevice() {
        print("当前登录账号在其它设备登录")
    }
    // 当前登录账号已经被从服务器端删除时会收到该回调
    func userAccountDidRemoveFromServer() {
        print("当前登录账号已经被从服务器端删除")
    }
}

// 专门处理环信联系人逻辑代理
extension AppDelegate: EMContactManagerDelegate {
    /// 监听加好友请求
    // 用户A发送加用户B为好友的申请，用户B会收到这个回调
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        print("接收到好友申请")
        // 发送接收到好友请求通知
        NOTIFY_POST(name: KFriendRequestDidReceive, object: nil, userInfo: ["chatId": aUsername, "message": aMessage])
    }
    
    /// 好友申请处理结果回调
    // 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
    func friendRequestDidApprove(byUser aUsername: String!) {
        print("\(aUsername)同意了你的加好友请求")
        NOTIFY_POST(name: KContactListDidUpdateNotification, object: "didApprove", userInfo: ["userId": aUsername])
    }
    
    // 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
    func friendRequestDidDecline(byUser aUsername: String!) {
        print("\(aUsername)拒绝了你的加好友请求")
    }
    
    /// 删除好友回调
    // 用户B删除与用户A的好友关系后，用户A，B会收到这个回调
    func friendshipDidRemove(byUser aUsername: String!) {
        let currentUsername = EMClient.shared().currentUsername
        if currentUsername == aUsername {
            print("删除好友成功")
        } else {
            print("\(aUsername)已经将您从好友列表中删除")
        }
    }
}

// 专门处理环信聊天消息逻辑代理
extension AppDelegate: EMChatManagerDelegate {
    /// 接收消息回调
    // 接收到一条及以上非cmd消息
    func messagesDidReceive(_ aMessages: [Any]!) {
        guard let aMessages = aMessages as? [EMMessage] else { return }
        MessageHelper.shared.handleReceivedMessage(aMessages: aMessages)
        NOTIFY_POST(name: KUpdateMessage)
    }
}

// 专门处理环信<组群>聊天消息逻辑代理
extension AppDelegate: EMGroupManagerDelegate {
    // 被邀请用户收到回调
    func didJoin(_ aGroup: EMGroup!, inviter aInviter: String!, message aMessage: String!) {
        print("我加入了群组，邀请人: \(aInviter)")
    }
    // 群内用户收到回调
    func userDidJoin(_ aGroup: EMGroup!, user aUsername: String!) {
        print("用户 \(aUsername) 加入了群组")
    }

}

// 专门处理leancloud初始化
extension AppDelegate {
    // leancloud初始化
    func initLeanCloud() {
        LeanCloud.initialize(applicationID: "50X4GQbi2cpdQADHywGIDnCy-gzGzoHsz", applicationKey: "d1yUfnjaFk6ROJLBJH7EPLi5")
    }
}
