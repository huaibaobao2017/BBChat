//
//  BaseSearchViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
// 基础搜索 控制器
class BaseSearchViewController: UISearchController {
    
    lazy var containerView: UIView = {
        guard let view = self.view.subviews.first else { return UIView() }
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {}
    
}

extension BaseSearchViewController {
    
    private func setup() {
        self.definesPresentationContext = true
        let image = UIImage.imageWithColor(color: UIColor.colorHex(hex: "#efeff4"))
        self.searchBar.setBackgroundImage(image, for: .any, barMetrics: .default)
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.placeholder = "搜索"
        self.searchBar.tintColor = mainColor
    }
 
}

