//
//  BaseEditingTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/6/1.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class BaseEditingTableViewCell: UITableViewCell {
    
    weak var controller: UIViewController? = nil {
        didSet {
            updateUI()
        }
    }
    // 用户输入的昵称
    var inputText: String? {
        didSet {
            UserDefaults.standard.set(inputText, forKey: "requestMessage")
            UserDefaults.standard.synchronize()
        }
    }
    
    private lazy var vm = NickNameSettingViewModel()
    
    lazy var textField: UITextField = { [unowned self] in
        var textField = UITextField()
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        return textField
        }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension BaseEditingTableViewCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.addSubview(textField)
    }
    
    private func updateUI() {
        textField.becomeFirstResponder()
    }
    
    private func layoutSubview() {
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
        }
    }
    
}

extension BaseEditingTableViewCell {
    // 监听内容改变
    @objc func textFieldValueChanged(textField: UITextField) {
        guard let text = textField.text else { return }
        self.inputText = text
        let isEnabled = text != ""
        self.controller?.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
}

extension BaseEditingTableViewCell: UITextFieldDelegate {
    // return 收起键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



