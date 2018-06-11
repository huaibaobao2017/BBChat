//
//  Register.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class RegisterView: MenberBaseCollectionView {
    
    var menberForm = MenberForm() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var controller: UIViewController?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMenberCollectionViewCellID, for: indexPath) as! MenberCollectionViewCell
        cell.controller = self.controller
        cell.menberForm = self.menberForm
        return cell
    }
    
}
