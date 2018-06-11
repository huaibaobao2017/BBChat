//
//  StrangerProfileFooterView.swift
//  BBChat
//
//  Created by bb on 2018/1/9.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class StrangerProfileFooterView: UIView {
    
    var contact: Contact? = nil
    
    weak var controller: UIViewController? = nil
    
    // 通过验证 按钮
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("通过验证", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor.withAlphaComponent(0.8)), for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(accept), for: .touchUpInside)
        return button
    }()
    
    // 加入黑名单 按钮
    lazy var addToBlackListButton: UIButton = {
        let button = UIButton()
        button.setTitle("加入黑名单", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.lightGray.withAlphaComponent(0.8)), for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(videoChat), for: .touchUpInside)
        return button
    }()
    
    // 投诉 按钮
    lazy var complainButton: UIButton = {
        let button = UIButton()
        button.setTitle("投诉", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColor.lightGray.withAlphaComponent(0.8)), for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        //        button.addTarget(self, action: #selector(videoChat), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StrangerProfileFooterView {
    
    private func setupUI() {
        self.addSubview(acceptButton)
        self.addSubview(addToBlackListButton)
        self.addSubview(complainButton)
    }

    private func layoutSubview() {
        acceptButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(44)
        }
        addToBlackListButton.snp.makeConstraints { (make) in
            make.left.equalTo(acceptButton)
            make.top.equalTo(acceptButton.snp.bottom).offset(15)
            make.right.equalTo(self.snp.centerX).offset(-10)
            make.height.equalTo(acceptButton)
        }
        complainButton.snp.makeConstraints { (make) in
            make.width.equalTo(addToBlackListButton)
            make.top.equalTo(addToBlackListButton)
            make.right.equalTo(acceptButton)
            make.height.equalTo(addToBlackListButton)
        }
    }
}

extension StrangerProfileFooterView {

    @objc private func accept() {
        guard let contact = self.contact else { return }
            print("通过验证")
        }

}

