//
//  Country.swift
//  Center
//
//  Created by bb on 2017/11/24.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Country: NSObject {
    
    @objc var countryName: String = ""
    
    @objc var countryPinyin: String = "" {
        didSet {
            countryPinyin = (countryPinyin as NSString).substring(to: 1).uppercased()
        }
    }
    
    @objc var phoneCode: String = ""
    
    @objc var countryCode: String = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
