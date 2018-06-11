//
//  MenberForm.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MenberForm: NSObject {
    
    @objc var title: String = ""
    
    @objc var buttonType: String = ""
    
    @objc var buttonTag: Int = 0
    
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
