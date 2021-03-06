//
//  MainTabBarViewController.swift
//  Center
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class MainTabBarViewController: UITabBarController {
    
    private let current = EMClient.shared().currentUsername ?? ""
    let user = UserDefaults.standard

    lazy var indexFlag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.tabBarController?.tabBar.isHidden = true
        // 设置badgeValue
        setContactBadgeValue()
        setSessionBadgeValue()
    }
    
}

// MARK: - setUpChildViewController
extension MainTabBarViewController {
    
    private func setupUI() {
        // 1.初始化所有的子控制器
        setupChildViewController()
        // 2.隐藏tabbar
        NOTIFY_ADD(target: self, name: KSearchControllerDelegate, selector: #selector(hideTabBar))
        // 3.监听好友请求
        NOTIFY_ADD(target: self, name: KFriendRequestDidReceive, selector: #selector(friendRequestDidReceive))
        // 3.监听新消息
        NOTIFY_ADD(target: self, name: KMessagesDidReceive, selector: #selector(messagesDidReceive))
        // 4.监听好友请求记录更新
        NOTIFY_ADD(target: self, name: KRequestDidUpdate, selector: #selector(requestDidUpdate))
    }
    
    private func setupChildViewController() {
        
        let conversationListVC = ChatListViewController()
        setupNavRootViewControllers(vc: conversationListVC, title: "消息", image: "tabbar_mainframe", selImage: "tabbar_mainframeHL")
        
        let contactListVC = ContactsViewController()
        setupNavRootViewControllers(vc: contactListVC, title: "通讯录", image: "tabbar_contacts", selImage: "tabbar_contactsHL")
        
        let discoverVC = UIViewController()
        setupNavRootViewControllers(vc: discoverVC, title: "发现", image: "tabbar_discover", selImage: "tabbar_discoverHL")

        let myVC = MyViewController()
        setupNavRootViewControllers(vc: myVC, title: "我", image: "tabbar_me", selImage: "tabbar_meHL")
    }
    
    // 初始化一个到导航控制器的控制器
    private func setupNavRootViewControllers(vc: UIViewController, title:String, image: String, selImage: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage.mg_RenderModeOriginal(imageName: selImage)
       
        var titleTextAttributes = [NSAttributedStringKey: Any]()
        titleTextAttributes[.foregroundColor] =  UIColor.lightGray
        vc.tabBarItem.setTitleTextAttributes(titleTextAttributes, for: .normal)
        titleTextAttributes[.foregroundColor] = mainColor
        vc.tabBarItem.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        self.addChildViewController(BaseNavigationController(rootViewController: vc))
    }
    
}

extension MainTabBarViewController {
    // 监听搜索控制器，是否隐藏tabbar
    @objc private func hideTabBar(n: Notification) {
        guard let userInfo = n.userInfo as? [String: Bool] else { return }
        guard let active = userInfo["active"] else { return }
        // 顶层栈显示隐藏tabbar，二级一律隐藏
        // TODO: -待优化
        for (_, child) in self.childViewControllers.enumerated() {
            if child.childViewControllers.count > 1 {
                self.tabBar.isHidden = true
                return
            } else {
                self.tabBar.isHidden = !active
            }
        }
    }
    
    // 接收到好友请求
    @objc func friendRequestDidReceive(note: Notification) {
        guard let userInfo = note.userInfo as? [String: String] else { return }
        guard let chatId = userInfo["chatId"] else { return }
        let message = userInfo["message"]
        // 从服务器获取添加人的详细信息
        ContactWebManager.shared.getContactFromServer(chatId: chatId) { (contact, error) in
            /// 1.发送APNs通知
            
            // 2.本地保存用户请求
            guard let contact = contact else { return }
            MGUserDefault.saveContactRequest(contact: contact, message: message)
            // 3.本地保存好友请求数量
            MGUserDefault.saveContactMessageCount(count: 1)
            // 4.联系人未读消息
            self.setContactBadgeValue()
        }
    }
    
    // 接收到新消息
    @objc func messagesDidReceive() {
        setSessionBadgeValue()
    }
    
    // 更新好友请求记录
    @objc func requestDidUpdate() {
        setContactBadgeValue()
    }

    // 设置 通讯录 badgeValue
    private func setContactBadgeValue() {
        let count = self.user.integer(forKey: "unreadcontact_\(current)")
        let tabbarItem = self.tabBar.items![1] as UITabBarItem
        if(count == 0) {
            tabbarItem.badgeValue = nil
        } else {
            tabbarItem.badgeValue = "\(count)"
        }
    }
    
    // 设置 消息 badgeValue
    private func setSessionBadgeValue() {
        let count = self.user.integer(forKey: "unreadmessage_\(current)")
        let tabbarItem = self.tabBar.items![0] as UITabBarItem
        if(count == 0) {
            tabbarItem.badgeValue = nil
        } else {
            tabbarItem.badgeValue = "\(count)"
        }
    }
    
}
