//
//  SettingViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/16.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import XLForm

class SettingViewController: BaseXLFormViewController {
    
    var settings = [Setting]() {
        didSet {
            self.initializeForm()
        }
    }
    
    private lazy var vm = SettingViewModel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        vm.loadData { (settings) in
            self.settings = settings
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        vm.loadData { (settings) in
            self.settings = settings
        }
    }
    
    func initializeForm() {
        
        var form: XLFormDescriptor
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        // tableview
        form = XLFormDescriptor(title: "设置")
        // section
        for (i, x) in settings.enumerated() {
            section = XLFormSectionDescriptor.formSection()
            form.addFormSection(section)
            // row
            for (j, y) in x.rows.enumerated() {
                let indexPath = IndexPath(row: j, section: i)
                row = XLFormRowDescriptor(tag: y, rowType: XLFormRowDescriptorTypeButton, title: y)
                row.cellConfig["textLabel.color"] = UIColor.black
                row.cellConfig["textLabel.font"] = UIFont.systemFont(ofSize: 17)
                // 退出
                if i == 3 && j == 0 {
                    row.cellConfig["textLabel.textAlignment"] = NSTextAlignment.center.rawValue
                    row.cellConfig["accessoryType"] = UITableViewCellAccessoryType.none.rawValue
                    row.action.formSelector = #selector(SettingViewController.logout)
                } else {
                    row.cellConfig["textLabel.textAlignment"] = NSTextAlignment.left.rawValue
                    row.action.viewControllerClass = vm.controller(indexPath: indexPath)
                }
                section.addFormRow(row)
            }
        }
        self.form = form
    }
    
    // 退出登录
    @objc private func logout(sender: XLFormRowDescriptor) {
        self.deselectFormRow(sender)
        LoginManager.logout()
    }
    
}
