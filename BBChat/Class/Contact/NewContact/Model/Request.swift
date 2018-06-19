//
//  Request.swift
//  BBChat
//
//  Created by bb on 2018/6/1.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class Request: Contact {

    // 附加信息
    @objc var message: String = ""
    
    @objc var isFriend: Bool {
        return ContactHelper.shared.isFriend(contact: self)
    }
    
}
