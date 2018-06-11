//
//  MyViewModel.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MyViewModel {
    weak var controller: UIViewController?
    lazy var mys = [My]()
}

extension MyViewModel {
    
    func loadData(success:([My])->()) {
        for i in myData {
            mys.append(My(dict: i))
        }
        success(mys)
    }
    
}

extension MyViewModel {
    
    // push 控制器
    func pushViewController(indexPath: IndexPath) {
        guard let vc = self.controller(indexPath: indexPath) else { return }
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return InfoViewController()
            default:
                return nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                return UIViewController()
            default:
                return nil
            }
        case 2:
            switch indexPath.row {
            case 0:
                return UIViewController()
            case 1:
                return UIViewController()
            case 2:
                return UIViewController()
            case 3:
                return UIViewController()
            default:
                return nil
            }
        case 3:
            switch indexPath.row {
            case 0:
                return SettingViewController()
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
}

