//
//  LoginManager.swift
//  Center
//
//  Created by bb on 2017/11/22.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

enum LoginType {
    case login
    case register
}

class LoginManager {
    weak static var controller: UIViewController?
    static let shared = LoginManager()
    private init(){}
}

extension LoginManager {
    // 解析错误信息Error
    private func errorText(error: Error?) -> String {
        guard let nsError = error as NSError? else { return "" }
        guard let errorText = nsError.userInfo["error"] else { return "" }
        return "\(errorText)"
    }
    
    class func check(phoneNumber: String, smsCode: String, type: LoginType) {
//        if phoneNumber == "" || smsCode == "" { return }
//        guard phoneNumber.isPhoneNumber == true else {
//            MGKeyController?.showHint(hint: "手机号格式不正确")
//            return
//        }
        if type == .login {
            login(userName: phoneNumber, password: smsCode)
        } else if type == .register {
            register(userName: phoneNumber, password: smsCode)
            //let nav = BaseNavigationController(rootViewController: NickNameSettingViewController())
            //self.controller?.present(nav, animated: true, completion: nil)
        }
    }
    
}

extension LoginManager {
    
    // 注册
    class func register(userName: String, password: String) {
        EMClient.shared().register(withUsername: userName, password: password) { (username, error) in
            if error == nil {
                login(userName: userName, password: password)
            } else {
                MGKeyController?.showHint(hint: "注册失败")
            }
        }
    }
    
    // 登录
    class func login(userName: String, password: String) {
        let isAutoLogin = EMClient.shared().options.isAutoLogin
        if isAutoLogin == false {
            EMClient.shared().login(withUsername: userName, password: password, completion: { (username, error) in
                if error == nil {
                    // 配置离线推送
                    MGAPNs.getPushNotificationOptionsFromServer()
                    MGKeyWindow?.rootViewController = MainTabBarViewController()
                } else {
                    MGKeyController?.showHint(hint: "登录失败")
                }
            })
        }
    }
    
    // 退出登录
    class func logout() {
        EMClient.shared().logout(false) { (error) in
            if error == nil {
                MGKeyController?.showHint(hint: "退出登录成功")
                let nvc = UINavigationController(rootViewController: LoginViewController())
                MGKeyWindow?.rootViewController = nvc
            } else {
                MGKeyController?.showHint(hint: "退出登录失败")
            }
        }
    }

}
