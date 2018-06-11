//
//  FormView.swift
//  Center
//
//  Created by bb on 2017/11/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    var menberForm = MenberForm() {
        didSet {
            updateUI()
        }
    }
    
    weak var controller: UIViewController? = nil {
        didSet {
            LoginManager.controller = self.controller
        }
    }
    
    // 是否禁用按钮
    private var isActive: Bool {
        return phoneTextField.text != "" && verificationCodeField.text != ""
    }
    
    // 国家／地区
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 90, height: 20))
        label.text = "国家/地区"
        label.textAlignment = .left
        label.textColor = UIColor.colorHex(hex: "#333333")
        return label
    }()
    
    // 箭头
    private lazy var rightArrowImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 44))
        view.image = UIImage(named: "ic_element_titlebar_arrow_left_normal")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // 国家／地区
    lazy var countryTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.delegate = self
        textField.leftView = countryLabel
        textField.leftViewMode = .always
        textField.rightView = rightArrowImageView
        textField.rightViewMode = .always
        textField.text = "中国"
        textField.textColor = UIColor.colorHex(hex: "#333333")
        textField.tintColor = mainColor
        textField.addTarget(self, action: #selector(FormView.textFieldDidChangeValue), for: .allEditingEvents)
        return textField
    }()
    
    // 手机区号
    private lazy var zoneCodeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 90, height: 44))
        label.text = "+86"
        label.textColor = UIColor.colorHex(hex: "#333333")
        return label
    }()
    
    // 手机号码
    lazy var phoneTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.leftView = zoneCodeLabel
        textField.leftViewMode = .always
        textField.placeholder = "手机号码"
        textField.keyboardType = .numberPad
        textField.enablesReturnKeyAutomatically = true
        textField.clearButtonMode = .whileEditing
        textField.textColor = UIColor.colorHex(hex: "#333333")
        textField.tintColor = mainColor
        textField.addTarget(self, action: #selector(FormView.textFieldDidChangeValue), for: .allEditingEvents)
        return textField
    }()
    
    ///
    // 验证码
    private lazy var verificationCodeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 90, height: 44))
        label.text = "验证码"
        label.textAlignment = .left
        label.textColor = UIColor.colorHex(hex: "#333333")
        return label
    }()
    // 获取验证码 按钮
    private lazy var verificationCodeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 24))
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor.colorHex(hex: "#333333"), for: .normal)
        button.setTitleColor(UIColor.colorHex(hex: "#666666"), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorHex(hex: "#333333").cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(smsCode), for: .touchUpInside)
        return button
    }()
    // 请输入验证码
    lazy var verificationCodeField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.leftView = verificationCodeLabel
        textField.rightView = verificationCodeButton
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.placeholder = "请输入验证码"
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.textColor = UIColor.colorHex(hex: "#333333")
        textField.tintColor = mainColor
        textField.addTarget(self, action: #selector(FormView.textFieldDidChangeValue), for: .allEditingEvents)
        return textField
    }()

    // 登录/注册 按钮
    lazy var button: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor.withAlphaComponent(0.8)), for: .highlighted)
        button.setBackgroundImage(UIImage.imageWithColor(color: mainColor.withAlphaComponent(0.8)), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(finished), for: .touchUpInside)
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

extension FormView {
    
    private func setupUI() {
        self.addSubview(countryTextField)
        self.addSubview(phoneTextField)
        self.addSubview(verificationCodeField)
        self.addSubview(button)
    }
    
    private func updateUI() {
        self.button.setTitle(self.menberForm.buttonType, for: .normal)
        self.button.tag = self.menberForm.buttonTag
        LoginManager.controller = self.controller
    }
    
    private func updateUI(countryName: String, phoneCode: String) {
        countryTextField.text = countryName
        zoneCodeLabel.text = "+\(phoneCode)"
    }
    
    private func layoutSubview() {
        countryTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(44)
        }
        phoneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(countryTextField)
            make.top.equalTo(countryTextField.snp.bottom)
            make.right.equalTo(countryTextField)
            make.height.equalTo(countryTextField)
        }
        verificationCodeField.snp.makeConstraints { (make) in
            make.left.equalTo(phoneTextField)
            make.top.equalTo(phoneTextField.snp.bottom)
            make.right.equalTo(phoneTextField)
            make.height.equalTo(phoneTextField)
        }
        button.snp.makeConstraints { (make) in
            make.left.equalTo(verificationCodeField)
            make.top.equalTo(verificationCodeField.snp.bottom).offset(44)
            make.right.equalTo(verificationCodeField)
            make.height.equalTo(verificationCodeField)
        }
        let layer1 = UIView.borderWithView(view: countryTextField, bottom: true)
        countryTextField.layer.addSublayer(layer1)
        let layer2 = UIView.borderWithView(view: phoneTextField, bottom: true)
        phoneTextField.layer.addSublayer(layer2)
        let layer3 = UIView.borderWithView(view: verificationCodeField, bottom: true)
        verificationCodeField.layer.addSublayer(layer3)
        let layer4 = UIView.borderWithView(view: zoneCodeLabel, right: true, offset: -10)
        zoneCodeLabel.layer.addSublayer(layer4)
    }
    
}

extension FormView {
    
    // textfield 实时改变
    @objc private func textFieldDidChangeValue(textField: UITextField) {
        if isActive == true {
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
        guard let text = textField.text else { return }
        guard text != "" else { return }
        let length = text.length
        switch textField {
        case phoneTextField:
            // 限制输入手机号长度11位
            if length > 11 {
                textField.text = text.subString(from: 0, length: 11)
            }
        default:
            break
        }
    }
    
    // 获取手机验证码
    @objc private func smsCode() {
        //guard let phoneNumber = phoneTextField.text else { return }
    }
    
    // 点击注册／登录
    @objc private func finished(button: UIButton) {
        switch button.tag {
        case 1001:
            // 注册
            guard let phoneNumber = phoneTextField.text else { return }
            guard let smsCode = verificationCodeField.text else { return }
            LoginManager.check(phoneNumber: phoneNumber, smsCode: smsCode, type: .register)
        case 1002:
            // 登录
            guard let phoneNumber = phoneTextField.text else { return }
            guard let smsCode = verificationCodeField.text else { return }
            LoginManager.check(phoneNumber: phoneNumber, smsCode: smsCode, type: .login)
        default:
            break
        }
    }
    
}

extension FormView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case countryTextField:
            phoneCode()
            return false
        default:
            return true
        }
    }
    
    // 打开国家／区域 控制器(重写父类方法)
    private func phoneCode() {
        let vc = PhoneCodeViewController()
        vc.phoneCodeView.postValueBlock = { (countryName, phoneCode) in
            self.updateUI(countryName: countryName, phoneCode: phoneCode)
        }
        let nav = UINavigationController(rootViewController: vc)
        self.controller?.present(nav, animated: true, completion: nil)
    }
    
}
