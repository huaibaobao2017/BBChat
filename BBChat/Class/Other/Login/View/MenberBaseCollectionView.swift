//
//  BaseView.swift
//  Center
//
//  Created by bb on 2017/12/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

private let KMenberBaseCollectionViewCellID = "KMenberBaseCollectionViewCellID"
let KMenberCollectionViewCellID = "KMenberCollectionViewCellID"

class MenberBaseCollectionView: UIView {

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
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
        self.addSubview(collectionView)
    }
    
    private func updateUI() {
        collectionView.reloadData()
    }
    
    private func layoutSubview() {
        collectionView.frame = self.bounds
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
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
