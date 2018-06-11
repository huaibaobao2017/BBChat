//
//  BaseNavigationController.swift
//  Center
//
//  Created by bb on 2017/11/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

// MARK: - 生命周期
class BaseNavigationController: UINavigationController {
    
    public class func initializeOnceMethod() {
        // 设置导航栏的颜色
        BaseNavigationController.setupNavAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //layoutSubview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubview()
    }
    
    private func setupUI() {
        self.navigationBar.barStyle = .black
        self.navigationBar.tintColor = UIColor.white
    }
    
    private func layoutSubview() {

    }
    
}

// MARK: - 拦截控制器的push操作
extension BaseNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            // 此次可自定义返回按钮
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // 回到栈顶控制器
    public func popToRootVC() {
        popToRootViewController(animated: true)
    }
}

// MARK: - 设置导航栏肤色
extension BaseNavigationController {

    private class func setupNavAppearance() {
        // ======================  bar ======================
        let navBarAppearance = UINavigationBar.appearance()
        var titleTextAttributes = [NSAttributedStringKey: Any]()
        titleTextAttributes[.foregroundColor] =  UIColor.white
        titleTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 19)
        navBarAppearance.titleTextAttributes = titleTextAttributes
        
        // ======================  item  =======================
        let barItemAppearence = UIBarButtonItem.appearance()
        // 设置导航字体
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.foregroundColor] = UIColor.white
        barItemAppearence.setTitleTextAttributes(attributes, for: .normal)
        barItemAppearence.setTitleTextAttributes(attributes, for: .highlighted)
    }
}
