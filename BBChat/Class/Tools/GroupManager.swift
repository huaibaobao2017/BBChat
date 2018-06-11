//
//  GroupManager.swift
//  BBChat
//
//  Created by bb on 2018/1/3.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

struct GroupManager {
    static let shared = GroupManager()
    private init(){}
}

extension GroupManager {
    
    // 从服务器获取与我相关的群组列表
    func getJoinedGroupsFromServer(page: Int, size: Int, successCallback: @escaping (_ groups: [EMGroup])->()) {
        EMClient.shared().groupManager.getJoinedGroupsFromServer(withPage: page, pageSize: size) { (groups, error) in
            if error == nil {
                print("从服务器获取群组列表成功")
                guard let groups = groups as? [EMGroup] else { return }
                successCallback(groups)
            } else {
                print("获取群组列表失败")
            }
        }
    }
    
    // 从内存中获取所有群组，第一次从数据库加载
    func getJoinedGroupsFromLocal(page: Int, size: Int, successCallback: @escaping (_ groups: [EMGroup])->()) {
        guard let groups = EMClient.shared().groupManager.getJoinedGroups() as? [EMGroup] else {
            print("从本地获取群组列表失败")
            self.getJoinedGroupsFromServer(page: page, size: size, successCallback: { groups in
                successCallback(groups)
            })
            return
        }
        // 获取到的数组为空
        if groups.isEmpty {
            self.getJoinedGroupsFromServer(page: page, size: size, successCallback: { groups in
                successCallback(groups)
            })
        } else {
            print("从本地获取好友列表成功")
            successCallback(groups)
        }
    }
    
    // 创建群组
    func createGroup(invitees: [String], successCallback: @escaping (_ groups: EMGroup)->()) {
        let options = EMGroupOptions()
        options.maxUsersCount = 200
        //邀请群成员时，是否需要发送邀请通知.若false，被邀请的人自动加入群组
        options.isInviteNeedConfirm = false
        // 创建不同类型的群组，这里需要才传入不同的类型
        options.style = EMGroupStylePrivateMemberCanInvite
        EMClient.shared().groupManager.createGroup(withSubject: "群聊", description: "群组描述", invitees: invitees, message: "邀请您加入群组", setting: options) { (group, error) in
            if error == nil {
                // TODO: -发送cmd消息通知被邀请用户
                guard let group = group else { return }
                print("创建成功")
                successCallback(group)
            } else {
                print("创建失败")
            }
        }
    }
    
    // 获取群详情
    func getGroupSpecificationFromServerWithId(groupId: String) {
        EMClient.shared().groupManager.getGroupSpecificationFromServer(withId: groupId) { (group, error) in
            if error == nil {
                print("获取群组成功，groupId为\(groupId)")
            } else {
                print("获取群组失败")
            }
        }
    }
    
}
