//
//  NewContactViewModel.swift
//  BBChat
//
//  Created by bb on 2018/5/30.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class NewContactViewModel {
    
    private let current = EMClient.shared().currentUsername ?? ""
    weak var controller: UIViewController?

}

extension NewContactViewModel {
    
    func loadData(callback: ([SortedRequest])->()) {
        guard let requests = UserDefaults.standard.array(forKey: "newfriend_\(current)") as? [[String: Any]] else {
            return
        }
        let systemDate = Date.systemDate
        // 大于三天
        let arr1 = requests.filter { (r) -> Bool in
            guard let creatDate = r["date"] as? Date else { return false }
            let days = Date.getDaysBetweenDates(formDate: creatDate, toDate: systemDate)
            return days <= 3
        }
        
        let contacts1 = arr1.map { (r) -> Request in
            guard let data = r["data"] as? Data else { return Request() }
            guard let message = r["message"] as? String else { return Request() }
            guard let request = NSKeyedUnarchiver.unarchiveObject(with: data) as? Request else { return Request() }
            request.message = message
            return request
        }
        
        let arr2 = requests.filter { (r) -> Bool in
            guard let creatDate = r["date"] as? Date else { return false }
            let days = Date.getDaysBetweenDates(formDate: creatDate, toDate: systemDate)
            return days > 3
        }
        
        let contacts2 = arr2.map { (r) -> Request in
            guard let data = r["data"] as? Data else { return Request() }
            guard let message = r["message"] as? String else { return Request() }
            guard let request = NSKeyedUnarchiver.unarchiveObject(with: data) as? Request else { return Request() }
            request.message = message
            return request
        }
        
        var arr = [SortedRequest]()
        if(!contacts1.isEmpty) {
            let sort = SortedRequest()
            sort.sectionTitle = "近三天"
            sort.requests = contacts1
            arr.append(sort)
        }
        if(!contacts2.isEmpty) {
            let sort = SortedRequest()
            sort.sectionTitle = "三天前"
            sort.requests = contacts2
            arr.append(sort)
        }
        callback(arr)
    }
    
    
    
    /// 会话列表控制器跳转逻辑
    
    // push 控制器
    func pushViewController(indexPath: IndexPath, requests: [SortedRequest]?) {
        guard let vc = self.controller(indexPath: indexPath), let requests = requests else { return }
        if vc.isKind(of: StrangerProfileViewController.self) {
            let requests = requests[indexPath.section - 1].requests
            let request = requests[indexPath.row]
            if request.chatId != "" {
                guard let vc = vc as? StrangerProfileViewController else { return }
                vc.request = request
            }
        }
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 简单跳转路由
    private func controller(indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return UIViewController() // 手机联系人
            default:
                return nil
            }
        case 1:
            return StrangerProfileViewController() // 陌生人详情
        default:
            return nil
        }
    }
    
}
