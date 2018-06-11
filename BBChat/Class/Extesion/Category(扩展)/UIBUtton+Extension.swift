//
//  UIBUtton+Extension.swift
//  Center
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(imageName:String, target:AnyObject, action:Selector) {
        self.init()
        
        // 1.设置按钮的属性
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        sizeToFit()
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(title:String, target:AnyObject, action:Selector) {
        self.init()
        setTitle(title, for: UIControlState.normal)
        sizeToFit()
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(imageName:String, title: String, target:AnyObject, action:Selector) {
        self.init()
        // 1.设置按钮的属性
        setImage(UIImage(named: imageName), for: .normal)
        setTitle(title, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }
}

extension UIButton {
    typealias MGButtonBlock = ((Any)->())
    // MARK:- RuntimeKey   动态绑属性
    // 改进写法【推荐】
    fileprivate struct RuntimeKey {
        static let mg_BtnBlockKey = UnsafeRawPointer.init(bitPattern: "mg_BtnBlockKey".hashValue)
        /// ...其他Key声明
    }
    
    convenience init(actionBlock: @escaping MGButtonBlock) {
        self.init()
        addActionBlock(actionBlock)
        addTarget(self, action: #selector(invoke(_:)), for: .touchUpInside)
    }
    
    fileprivate func addActionBlock(_ block: MGButtonBlock?) {
        if (block != nil) {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.mg_BtnBlockKey!, block!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func invoke(_ sender: Any) {
        let block = objc_getAssociatedObject(self, UIButton.RuntimeKey.mg_BtnBlockKey!) as? MGButtonBlock
        if (block != nil) {
            block!(sender);
        }
    }
    
    convenience init(imageName: UIImage, title: String,actionBlock: @escaping MGButtonBlock) {
        self.init(actionBlock: actionBlock)
        // 1.设置按钮的属性
        setImage(imageName, for: .normal)
        setTitle(title, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        sizeToFit()
    }
    
    convenience init(title: String,actionBlock: @escaping MGButtonBlock) {
        self.init(actionBlock: actionBlock)
        // 1.设置按钮的属性
        setTitle(title, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        sizeToFit()
    }
    
    convenience init(norImage:UIImage,pressImage: UIImage,actionBlock: @escaping MGButtonBlock) {
        self.init(actionBlock: actionBlock)
        // 1.设置按钮的属性
        setImage(norImage, for: .normal)
        setImage(pressImage, for: .highlighted)
    }
    
    convenience init(norImage:UIImage,selectedImage: UIImage,actionBlock: @escaping MGButtonBlock) {
        self.init(actionBlock: actionBlock)
        // 1.设置按钮的属性
        setImage(norImage, for: .normal)
        setImage(selectedImage, for: .selected)
    }
}
