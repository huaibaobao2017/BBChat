//
//  MenberFormViewModel.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

enum MenberActionType {
    case login
    case register
}

class MenberFormViewModel: NSObject {
    
    lazy var menberForm = MenberForm()
    
}

extension MenberFormViewModel {
    
    func loadData(type: MenberActionType, finishedCallback: @escaping ()->()) {
        
        var dict = [String: String]()
        
        if type == .login {
            dict = loginData
        } else {
            dict = registerData
        }
        
        menberForm = MenberForm(dict: dict)

        finishedCallback()
        
    }
    
}
