//
//  MultipleSearchView.swift
//  BBChat
//
//  Created by bb on 2017/12/30.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
// 综合搜索 自定义view
class MultipleSearchView: UIView {
    
    
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

extension MultipleSearchView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.green
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

