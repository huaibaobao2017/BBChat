//
//  InfoViewModel.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import XLForm

class InfoViewModel: NSObject {
    weak var controller: UIViewController?
    lazy var settings = [Setting]()
}

extension InfoViewModel {
    
    func loadData(success:([Setting])->()) {
        for i in infoData {
            settings.append(Setting(dict: i))
        }
        success(settings)
    }
    
}

extension InfoViewModel {
    
    // push 控制器
    func openViewController(indexPath: IndexPath) {
        guard let vc = self.controller(indexPath: indexPath) else { return }
        // 获取类名
        let className = NSStringFromClass(type(of: vc))
        let setting = className.range(of: "Setting")
        if setting != nil {
            let nav = BaseNavigationController(rootViewController: vc)
            self.controller?.present(nav, animated: true, completion: nil)
        } else {
            self.controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return AvatarViewController() // 头像
            case 1:
                return NickNameEditingViewController(style: .grouped) // 名字
            case 2:
                return UIViewController() // 聊天号
            case 3:
                return UIViewController() // 我的二维码
            case 4:
                return UIViewController() // 我的二维码
            default:
                return nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                return UIViewController() // 我的地址
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
}


