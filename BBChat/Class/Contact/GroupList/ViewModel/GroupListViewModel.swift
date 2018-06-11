//
//  GroupListViewModel.swift
//  BBChat
//
//  Created by bb on 2018/1/3.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class GroupListViewModel {
    weak var controller: UIViewController?
}

extension GroupListViewModel {
    
    /// 群组列表控制器跳转逻辑
    
    // push 控制器
    func openViewController(indexPath: IndexPath, groups: [EMGroup]) {
        let group = groups[indexPath.row]
        let vc = ChatViewController(conversationId: group.groupId, conversationType: EMConversationTypeGroupChat)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            return nil // 会话控制器
        default:
            return nil
        }
    }

}
