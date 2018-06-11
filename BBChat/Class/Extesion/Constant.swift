//
//  APIKey.swift
//  BBChat
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

// "Apple ID 为您的 App 自动生成的 ID。
let appid = "1228164508"

/// Leancloud云存储
let leanCloudAppId = "50X4GQbi2cpdQADHywGIDnCy-gzGzoHsz"
let leanCloudAppKey = "d1yUfnjaFk6ROJLBJH7EPLi5"
/// 环信
let hyphenateAppKey = "1162171220178932#bbchat"

// MARK:- 全局参数
let MGScreenBounds = UIScreen.main.bounds
let MGScreenW = UIScreen.main.bounds.size.width
let MGScreenH = UIScreen.main.bounds.size.height

/// 会话工具栏高度
let MGInputBarHeight: CGFloat = 49
/// 滚动导航栏高度
let MGScrollSegmentViewHeight: CGFloat = 40
/// 轮播图高度
let MGCycleViewHeight = MGScreenW/3 - 10
/// 状态栏高度20
let MGStatusHeight: CGFloat = 20
/// 导航栏高度64
let MGNavHeight: CGFloat = 64
/// tabBar的高度 50
let MGTabBarHeight: CGFloat = 50
/// 全局的间距 10
let MGGloabalMargin: CGFloat = 10
/// 导航栏颜色
let mainColor  = UIColor.init(r: 26, g: 173, b: 25)
let mainColorHightLighted  = UIColor.init(r: 26, g: 173, b: 25, a: 0.8)

/// 记录服务器IP
let MGServeraddressKey = "MGServeraddressKey"

// iOS在当前屏幕获取第一响应
let MGKeyWindow = UIApplication.shared.keyWindow
let MGKeyController = MGKeyWindow?.rootViewController

// MARK:- 通讯录管理类
/// 通讯录
let MGContact = ContactManager.shared

// MARK:- 聊天管理类
/// 聊天管理
let MGMessage = MessageManager.shared

// MARK:- 会话管理类
/// 会话管理
let MGConversation = ConversationManager.shared

// MARK:- APNs管理类
/// APNs管理
let MGAPNs = APNsManager.shared

// MARK:- Group组群管理类
let MGGroup = GroupManager.shared

// MARK:- userdefaults管理类
let MGUserDefault = UserDefaultsManager.shared

// MARK:- 通知
/// 通知中心
let MGNotificationCenter = NotificationCenter.default

// 添加监听
func NOTIFY_ADD(target: Any, name: String, selector: Selector) {
    MGNotificationCenter.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
}
// 发送监听
func NOTIFY_POST(name: String, object: Any? = nil, userInfo: [String: Any]? = nil) {
    MGNotificationCenter.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
}
// 移除监听
func NOTIFY_REMOVE(target: Any) {
    MGNotificationCenter.removeObserver(target)
}

// MARK:- 首页排序的通知
/// 通知刷新(联系人 头像／昵称 等发生改变)
let KContactInfoDidUpdateNotification = "KContactInfoDidUpdateNotification"
/// 添加/删除 联系人
let KContactListDidUpdateNotification = "KContactListDidUpdateNotification"
/// 更新信息
let KUpdateMessage = "KUpdateMessage"
/// 点击发送按钮
let KSendMessageNotification = "KSendMessageNotification"
/// 从视频广告进入root
let KEnterHomeViewNotification = "KEnterHomeViewNotification"
/// 创建群聊成功
let KCreatGroupNotification = "KCreatGroupNotification"
/// 搜索控制器代理（通知）
let KSearchControllerDelegate = "KSearchControllerDelegate"
/// 搜索联系人
let KSearchContactNotification = "KSearchContactNotification"
/// 接收到好友请求
let KFriendRequestDidReceive = "KFriendRequestDidReceive"
/// 接收到消息
let KMessagesDidReceive = "KMessagesDidReceive"

