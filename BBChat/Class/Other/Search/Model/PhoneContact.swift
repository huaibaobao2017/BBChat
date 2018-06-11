//
//  PhoneContact.swift
//  BBChat
//
//  Created by bb on 2018/1/5.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class PhoneContact: NSObject {

    @objc var name: String = ""
    
    @objc var phoneNumber: String = ""
    
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
