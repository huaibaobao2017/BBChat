//
//  BaseView.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import CoreMotion

private let KMenberBaseCollectionViewCellID = "KMenberBaseCollectionViewCellID"
let KMenberCollectionViewCellID = "KMenberCollectionViewCellID"

class MenberBaseCollectionView: UIView {
    
    // 传感器
    lazy var motionManager = CMMotionManager()
    
    // 背景图片
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "login-bg")
        return view
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KMenberBaseCollectionViewCellID)
        collectionView.register(MenberCollectionViewCell.self, forCellWithReuseIdentifier: KMenberCollectionViewCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        startDeviceMotionUpdates()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenberBaseCollectionView {
    
    private func setupUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(collectionView)
    }
    
    private func updateUI() {
        collectionView.reloadData()
    }
    
    private func layoutSubview() {
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 3, height: self.bounds.height * 3)
        backgroundImageView.center = self.center
        collectionView.frame = self.bounds
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
}

extension MenberBaseCollectionView {
    // 陀螺仪开始更新数据
    func startDeviceMotionUpdates() {
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (motion, error) in
            guard error == nil else {
                print(error!)
                return
            }
            self.calculateRotationByGyro(motion: motion!)
        }
    }
    // 陀螺仪停止更新数据
    func stopDeviceMotionUpdates() {
        self.motionManager.stopDeviceMotionUpdates()
    }
    // 根据陀螺仪x y z 轴更新背景图frame
    func calculateRotationByGyro(motion: CMDeviceMotion) {
        let x = motion.rotationRate.x
        let y = motion.rotationRate.y
        let preX = backgroundImageView.frame.origin.x
        let preY = backgroundImageView.frame.origin.y
        let nowX = preX + CGFloat(y)
        let nowY = preY + CGFloat(x)
        backgroundImageView.frame = CGRect(x: nowX, y: nowY, width: backgroundImageView.frame.width, height: backgroundImageView.frame.height)
    }
}

extension MenberBaseCollectionView: UICollectionViewDelegateFlowLayout {

}

extension MenberBaseCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMenberBaseCollectionViewCellID, for: indexPath)
        return cell
    }
    
}
