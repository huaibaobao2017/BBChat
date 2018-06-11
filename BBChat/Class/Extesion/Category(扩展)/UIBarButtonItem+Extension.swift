//
//  UIBarButtonItem+Extension.swift
//  Center
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // UIBarButtonItem的封装
    convenience init(image: UIImage? = nil, highImage: UIImage? = nil, norColor: UIColor? = UIColor.white, selColor: UIColor? = UIColor.lightGray, title: String?, target: Any, action: Selector) {
        let backBtn = UIButton(type: .system)
        /// 1.设置照片
        if image != nil {
            backBtn.setImage(image, for: .normal)
        }

        if highImage != nil {
            backBtn.setImage(highImage, for: .highlighted)
        }
        
        /// 2.设置文字以及颜色
        if title != nil {
             backBtn.setTitle(title, for: .normal)
        }
        backBtn.tintColor = norColor
        backBtn.setTitleColor(norColor, for: .normal)
        backBtn.setTitleColor(selColor, for: .highlighted)
        backBtn.sizeToFit()
        backBtn.addTarget(target, action: action, for: .touchUpInside)
        // 修复ios11 无法移动uibaritem的问题
        if #available(iOS 11.0, *) {
            backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -9)
            backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        }
        self.init(customView: backBtn)
    }
    
    // UIBarButtonItem的封装
    convenience init(image: UIImage, highImage: UIImage? = nil,title: String, target: Any, action: Selector) {
        self.init(image: image, highImage: highImage, norColor: UIColor.white, selColor: UIColor.lightGray, title: title, target: target, action: action)
    }
    
    convenience init(image: UIImage, highImage: UIImage? = nil, target: Any, action: Selector) {
        self.init(image: image, highImage: highImage, norColor: UIColor.white, selColor: UIColor.lightGray, title: nil, target: target, action: action)
    }
    
    convenience init(title: String, target: Any, action: Selector) {
        self.init(image: nil, highImage: nil, norColor: UIColor.white, selColor: UIColor.lightGray, title: title, target: target, action: action)
    }
}
