//
//  UIAlertController+Extension.swift
//  Center
//
//  Created by bb on 2017/11/23.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

private var dismissBlock: ((_ buttonIndex: NSInteger)->())?
private var cancelBlock: (()->())?

extension UIAlertController {
    // 便利构造函数
    convenience init(title: String, message: String, preferredStyle: UIAlertControllerStyle, onDismissBlock: @escaping ()->(), onCancleBlock: (() -> Swift.Void)? = nil) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        let ok = UIAlertAction(title: "确定", style: .default) { (action) in
            onDismissBlock()
        }
        let cancel = UIAlertAction(title: "取消", style: .default) { (action) in
            if (onCancleBlock != nil) {
                onCancleBlock!()
            }
        }
        self.addAction(ok)
        self.addAction(cancel)
    }
    
}
