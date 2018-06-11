////
////  SelectContactViewModel.swift
////  BBChat
////
////  Created by bb on 2018/1/2.
////  Copyright © 2018年 bb. All rights reserved.
////
//
//import UIKit
//
//class SelectContactViewModel {
//    lazy var menbers = [Contact]()
//    weak var controller: UIViewController?
//}
//
//extension SelectContactViewModel {
//    
//    /// 选择联系人控制器跳转逻辑
//    
//    // push 控制器
//    func openViewController(indexPath: IndexPath, contacts: [SortedContact], callback:([Contact])->()) {
//        guard let vc = self.controller(indexPath: indexPath) else {
//            let contacts = contacts[indexPath.section - 1].contacts
//            let contact = contacts[indexPath.row]
//            if contact.userId != "" {
//                if menbers.isEmpty == true {
//                    menbers.append(contact)
//                } else {
//                    for (index, value) in menbers.enumerated() {
//                        print("数组：\(value.userId)   当前：\(contact.userId)")
//                        if value.userId == contact.userId {
//                            return
//                        } else {
//                            menbers.append(contact)
//                        }
//                    }
//                }
//                callback(menbers)
//            }
//            return
//        }
//        self.controller?.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    // 简单跳转路由
//    private func controller(indexPath: IndexPath) -> UIViewController? {
//        switch indexPath.section {
//        case 0:
//            switch indexPath.row {
//            case 0:
//                return UIViewController() // 选择一个群
//            case 1:
//                return UIViewController() // 面对面建群
//            default:
//                return nil
//            }
//        default:
//            return nil
//        }
//    }
//    
//}

