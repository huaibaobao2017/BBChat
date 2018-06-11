//
//  ContactSearchView.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
// 联系人搜索 自定义view
class ContactSearchView: UIView {
    
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

extension ContactSearchView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.yellow
        //        self.addSubview(tableView)
    }
    
    private func updateUI() {
        
    }
    
    private func layoutSubview() {
        //        tableView.snp.makeConstraints { (make) in
        //            make.edges.equalTo(self)
        //        }
    }
}
