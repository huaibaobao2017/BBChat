//
//  StrangerProfileHeaderView.swift
//  BBChat
//
//  Created by bb on 2018/6/11.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class StrangerProfileHeaderView: UIView {
    
    var contact = Contact() {
        didSet {
            updateUI()
        }
    }

    var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        return view
    }()
    
    var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorHex(hex: "#f9f9f9")
        return view
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "海绵宝宝: 为什么拉黑我？？？"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var replyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorHex(hex: "#f8f8f8")
        button.setTitle("回复", for: .normal)
        button.setTitleColor(UIColor.colorHex(hex: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.colorHex(hex: "#dfdfdf").cgColor
        button.layer.cornerRadius = 3
        return button
    }()
    
    // 分隔线
    lazy var separatorBottom: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.colorHex(hex: "#d9d9d9").cgColor
        layer.frame = CGRect(x: 0, y: (80+85), width: MGScreenW, height: 0.5)
        return layer
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

extension StrangerProfileHeaderView {
    
    private func setupUI() {
        self.layer.addSublayer(separatorBottom)
        self.addSubview(headerView)
        self.addSubview(messageView)
        self.addSubview(messageLabel)
        self.addSubview(replyButton)
    }
    
    private func updateUI() {
        self.headerView.contact = self.contact
    }
    
    private func layoutSubview() {
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(80)
        }
        messageView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(headerView.snp.bottom)
            make.right.equalTo(self)
            make.height.equalTo(85)
        }
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(messageView).offset(15)
            make.top.equalTo(messageView).offset(15)
            make.right.equalTo(messageView).offset(-15)
            make.height.lessThanOrEqualToSuperview()
        }
        replyButton.snp.makeConstraints { (make) in
            make.right.equalTo(messageView).offset(-15)
            make.bottom.equalTo(messageView).offset(-15)
            make.width.equalTo(60)
            make.height.equalTo(28)
        }
    }
}
