//
//  WaterFallLayoutExample.swift
//  SHUIKit_Example
//
//  Created by 杜林顺 on 2021/9/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SHUIKit

class WaterFallLayoutExample: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = WaterFallLayout()
        layout.delegate = self
        layout.columnCount = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "瀑布流"
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    deinit {
        print(" deinit", type(of: self))
    }
}

extension WaterFallLayoutExample: UICollectionViewDataSource, WaterFallLayoutDelegate, UICollectionViewDelegate {
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        return CGFloat(arc4random()%30 + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
