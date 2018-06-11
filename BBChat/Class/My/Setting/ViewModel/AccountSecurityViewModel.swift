//
//  AccountSecurityViewModel.swift
//  BBChat
//
//  Created by bb on 2018/1/16.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class AccountSecurityViewModel: NSObject {
    lazy var settings = [Setting]()
}

extension AccountSecurityViewModel {
    
    func loadData(success:([Setting])->()) {
        for i in securityData {
            settings.append(Setting(dict: i))
        }
        success(settings)
    }
    
}

extension AccountSecurityViewModel {
    
    // 简单跳转路由
    func controller(indexPath: IndexPath) -> AnyClass? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return UIViewController.self
            case 1:
                return UIViewController.self
            default:
                return nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                return SettingViewController.self
            case 1:
                return SettingViewController.self
            default:
                return nil
            }
        case 2:
            switch indexPath.row {
            case 0:
                return SettingViewController.self
            case 1:
                return SettingViewController.self
            case 2:
                return SettingViewController.self
            default:
                return nil
            }
        case 3:
            switch indexPath.row {
            case 0:
                return UIViewController.self
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
}
