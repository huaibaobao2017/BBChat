//
//  SortedCountry.swift
//  Center
//
//  Created by bb on 2017/11/24.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class SortedCountry: NSObject {
    
    @objc var firstLetter: String = ""

    @objc var countries = [Country]() {
        didSet {

        }
    }
    
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
