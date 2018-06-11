//
//  PhoneCodeView.swift
//  Center
//
//  Created by bb on 2017/11/27.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

typealias closureBlock = (String, String) -> Void

private let KPhoneCodeTableViewCellID = "KPhoneCodeTableViewCellID"

class PhoneCodeView: UIView {

    var sortedCountries = [SortedCountry]() {
        didSet {
            updateUI()
        }
    }
    // 闭包
    var postValueBlock: closureBlock?
    // GCD 定时器
    var timer: DispatchSourceTimer?
    // 字母索引 数组
    private lazy var indexTitles = [String]()
    
    private lazy var vm = PhoneCodeViewModel()
    
    weak var controller: UIViewController?
    
    private lazy var tipLabel: TipLabel = {
        let label = TipLabel()
        label.isHidden = true
        return label
    }()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.sectionIndexColor = UIColor.darkGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhoneCodeTableViewCell.self, forCellReuseIdentifier: KPhoneCodeTableViewCellID)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 释放资源
    deinit {
        timer?.cancel()
        timer = nil
    }
}

extension PhoneCodeView {
    
    private func setupUI() {
        self.addSubview(tableView)
        self.addSubview(tipLabel)
    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }
    
    private func layoutSubview() {
        tipLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension PhoneCodeView {
    
    private func loadData() {
        self.vm.loadData {
            self.indexTitles = self.vm.indexTitles
            self.sortedCountries = self.vm.sortedCountries
        }
    }
    
}

extension PhoneCodeView {
    
    // GCD 延时-更新索引(字母)
    private func updateIndexTitle(title: String) {
        self.tipLabel.isHidden = false
        self.tipLabel.title = title
        //定时器
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
        timer?.schedule(deadline: .now() + 0.5)
        timer?.setEventHandler {
            self.tipLabel.isHidden = true
        }
        timer?.resume()
    }
    
}

extension PhoneCodeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sortedCountries[section].firstLetter
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.indexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        self.updateIndexTitle(title: title)
        return index
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 闭包传值
        guard let postValueBlock = postValueBlock else { return }
        let country = self.sortedCountries[indexPath.section].countries[indexPath.row]
        let countryName = country.countryName
        let phoneCode = country.phoneCode
        postValueBlock(countryName, phoneCode)
        // 关闭控制器
        self.controller?.dismiss(animated: true, completion: nil)
    }
}

extension PhoneCodeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedCountries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCountries[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KPhoneCodeTableViewCellID, for: indexPath) as! PhoneCodeTableViewCell
        let country = self.sortedCountries[indexPath.section].countries[indexPath.row]
        cell.country = country
        return cell
    }
    
}
