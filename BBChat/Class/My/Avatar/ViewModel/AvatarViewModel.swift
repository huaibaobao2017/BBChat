//
//  AvatarViewModel.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Photos
import Hyphenate
//import AVOSCloud

struct AvatarViewModel {
    weak var controller: UIViewController?
}

extension AvatarViewModel {
    
    // actionsheet
    func actionsheet() {
        self.controller?.actionsheet(title: nil, message: nil, buttons: ["拍照", "从手机相册选择", "保存图片"]) { (index) in
            switch index {
            case 0:
                self.takePhoto()
            case 1:
                self.getPhoto()
            case 2:
                self.savePhoto()
            default:
                break
            }
        }
    }
    
    // 从相册获取图片
    private func getPhoto() {
        _ = self.controller?.zz_presentPhotoVC(1) { (assets) in
            DispatchQueue.global().async(execute: {
                // 解析图片
                guard let asset = assets.first else { return }
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
                    guard let image = image else { return }
                    self.updateMyAvatar(image: image)
                })
            })

        }
    }

    // 从相机获取图片
    private func takePhoto() {
        
    }
    
    // 保存图片至相册
    private func savePhoto() {
        
    }
    
}

extension AvatarViewModel {
    
    // 上传图片到leancloud云端 逻辑
    private func updateMyAvatar(image: UIImage) {
//        UserWebManager.updateMyAvatar(pickImage: image) { (newImage) in
//            if newImage == nil {
//                print("图片上传失败")
//                MGKeyController?.showHint(hint: "图片上传失败")
//                return
//            }
//            print("更新头像成功")
//            MGKeyController?.showHint(hint: "更新头像成功")
//            // 通知刷新
//            NOTIFY_POST(name: KContactInfoDidUpdateNotification)
//        }
    }
    
    
}
