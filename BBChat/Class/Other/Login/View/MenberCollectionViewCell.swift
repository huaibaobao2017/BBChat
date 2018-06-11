//
//  MenberCollectionViewCell.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MenberCollectionViewCell: UICollectionViewCell {
    
    var menberForm = MenberForm() {
        didSet {
            updateUI()
        }
    }
    
    weak var controller = UIViewController() {
        didSet {
            self.formView.controller = self.controller
        }
    }
    
    // 登录／注册 大标题
    lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    // 表单
    lazy var formView: FormView = {
        let view = FormView()
        return view
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

extension MenberCollectionViewCell {
    
    private func setupUI() {
        self.addSubview(titleView)
        self.addSubview(formView)
        // 添加点击手势
        addGestureRecognizer()
    }
    
    private func updateUI() {
        self.titleView.menberForm = self.menberForm
        self.formView.menberForm = self.menberForm
    }
    
    private func layoutSubview() {
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(30 + MGNavHeight)
            make.right.equalTo(self)
            make.height.equalTo(44)
        }
        formView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(titleView.snp.bottom).offset(30)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
    }
    
    // 添加点击手势
    func addGestureRecognizer() {
        let tap = UITapGestureRecognizer { (sender) in
            for subview in self.formView.subviews {
                if subview.isKind(of: UITextField.self) {
                    guard let textField = subview as? UITextField else { return }
                    if textField.canResignFirstResponder == true {
                        textField.resignFirstResponder()
                    }
                }
            }
        }
        self.addGestureRecognizer(tap)
    }
}
