//
//  NickNameSettingViewModel.swift
//  BBChat
//
//  Created by bb on 2017/12/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class NickNameSettingViewModel {
    weak var controller: UIViewController?
}

extension NickNameSettingViewModel {
    
    // 修改昵称到leancloud云端 逻辑
    func updateMyNickName(nickName: String) {
//        UserWebManager.updateMyNickName(nickName: nickName) { (successed) in
//            if successed == false {
//                MGKeyController?.showHint(hint: "昵称更新失败")
//                return
//            }
//            MGKeyController?.showHint(hint: "昵称更新成功")
//            // 通知刷新
//            NOTIFY_POST(name: KContactInfoDidUpdateNotification)
//        }
    }
    
}
