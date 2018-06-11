//
//  MultipleSearchViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/30.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
// 综合搜索 控制器
class MultipleSearchViewController: BaseSearchViewController {
    
    private lazy var multipleSearchView: MultipleSearchView = {
        let view = MultipleSearchView()
        return view
    }()
    
    override func setupUI() {
        self.multipleSearchView.frame = self.containerView.bounds
        self.containerView.insertSubview(multipleSearchView, at: 0)
    }

}

extension MultipleSearchViewController {
      
}
