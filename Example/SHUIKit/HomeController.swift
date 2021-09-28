//
//  HomeController.swift
//  SHUIKit_Example
//
//  Created by duarlen on 2021/9/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

struct HomeDataModel {
    let title: String
    let selected: (() -> ())
}

class HomeController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var dataModels: [HomeDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        dataModels.append(HomeDataModel(title: "标签", selected: { [weak self] in
            guard let `self` = self else { return }
            print("去标签示例")
        }))
        dataModels.append(HomeDataModel(title: "瀑布流", selected: { [weak self] in
            guard let `self` = self else { return }
            self.navigationController?.pushViewController(WaterFallLayoutExample(), animated: true)
        }))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        (cell as? HomeCell)?.titleLabel.text = dataModels[indexPath.row].title
        return cell
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column: CGFloat = 5
        let width = (collectionView.frame.width - 10 * (column + 2))/column
        return CGSize(width: width, height: width)
    }
}

extension HomeController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataModels[indexPath.row].selected()
    }
}

class HomeCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.backgroundColor = .white
        return lable
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
    }
}
