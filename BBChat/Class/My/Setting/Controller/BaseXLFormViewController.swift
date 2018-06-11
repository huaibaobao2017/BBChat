//
//  BaseSettingViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/16.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import XLForm

class BaseXLFormViewController: XLFormViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}
