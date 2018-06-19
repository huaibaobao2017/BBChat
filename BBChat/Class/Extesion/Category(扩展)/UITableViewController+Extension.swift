//
//  TableViewController+Extension.swift
//  BBChat
//
//  Created by bb on 2018/4/25.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    // 设置导航栏右item(系统样式-图标)
    func superNavigationBar(left: UIBarButtonSystemItem?, right: UIBarButtonSystemItem?, isClear: Bool) {
        let leftAction = #selector(leftItemAction)
        let rightAction = #selector(rightItemAction)
        if right != nil {
            let rightItem = UIBarButtonItem(barButtonSystemItem: right!, target: self, action: rightAction)
            self.navigationItem.rightBarButtonItem = rightItem
        }
        if left != nil {
            let leftItem = UIBarButtonItem(barButtonSystemItem: left!, target: self, action: leftAction)
            self.navigationItem.leftBarButtonItem = leftItem
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        }
        if isClear == true {
            let image = UIImage.imageWithColor(color: UIColor.clear)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            self.navigationController?.navigationBar.shadowImage = image
        }
    }
    // 设置导航栏右item(系统样式-文字)
    func superNavigationBar(left: String?, right: String?, isClear: Bool, color: UIColor? = UIColor.white) {
        let leftAction = #selector(leftItemAction)
        let rightAction = #selector(rightItemAction)
        if left != nil {
            let leftItem = UIBarButtonItem(title: left, style: .plain, target: self, action: leftAction)
            self.navigationItem.leftBarButtonItem = leftItem
        }
        if right != nil {
            let rightItem = UIBarButtonItem(title: right, style: .done, target: self, action: rightAction)
            rightItem.tintColor = color
            self.navigationItem.rightBarButtonItem = rightItem
        }
        if isClear == true {
            let image = UIImage.imageWithColor(color: UIColor.clear)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            self.navigationController?.navigationBar.shadowImage = image
        }
    }
    
    // 设置导航栏右item(自定义view)
    func superNavigationBar(normal: String, highlighted: String) {
        guard let normal = UIImage(named: normal) else { return }
        guard let highlighted = UIImage(named: highlighted) else { return }
        let rightAction = #selector(rightItemAction)
        let rightItem = UIBarButtonItem(image: normal, highImage: highlighted, norColor: UIColor.white, selColor: UIColor.white, title: nil, target: self, action: rightAction)
        if #available(iOS 11.0, *) {
            self.navigationItem.rightBarButtonItem = rightItem
        } else {
            let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            space.width = -5
            self.navigationItem.rightBarButtonItems = [space,rightItem]
        }
    }
    
    @objc func rightItemAction() {
        
    }
    
    @objc func leftItemAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
