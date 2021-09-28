//
//  WaterFallLayout.swift
//  SHUIKit
//
//  Created by 杜林顺 on 2021/9/28.
//

import UIKit

@objc
public protocol WaterFallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
}

public class WaterFallLayout: UICollectionViewLayout {
    
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var maps: [[Int: CGFloat]] = [[:]]
 
    public var columnCount: Int = 2
    public var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var minimumRowSpacing: CGFloat = 10
    public var minimumColumnSpacing: CGFloat = 10
    public weak var delegate: WaterFallLayoutDelegate?
    
    public override func prepare() {
        super.prepare()
        attributes.removeAll()
        guard let collectionView = collectionView else { return }
        guard collectionView.frame.width != 0 || collectionView.frame.height != 0 else { return }
        let itemWidth = CGFloat(ceil(Double(((collectionView.frame.width - sectionInset.left - sectionInset.right) - CGFloat(columnCount) * (minimumColumnSpacing - 1))/CGFloat(columnCount))))
        
        let sections = collectionView.numberOfSections
        for section in 0 ..< sections {
            let items = collectionView.numberOfItems(inSection: section)
            
            let maxHeight = maxHeight
            var map: [Int: CGFloat] = [:]
            for i in 0 ..< columnCount {
                map[i] = maxHeight
            }
            
            for item in 0 ..< items {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let itemHeight = delegate?.collectionView(collectionView, heightForItemAt: indexPath, itemWidth: itemWidth) ?? 0
                if let column = minHeightColumn(map) {
                    let x: CGFloat = (itemWidth + minimumColumnSpacing) * CGFloat(column)
                    let y: CGFloat = (map[column] ?? 0)
                    map[column] = y + itemHeight + minimumColumnSpacing
                    attribute.frame = CGRect(x: x + sectionInset.left, y: y + sectionInset.top, width: itemWidth, height: itemHeight)
                    attributes.append(attribute)
                }
            }
            
            for column in 0 ..< columnCount {
                map[column] = (map[column] ?? 0) + sectionInset.top + (section == sections - 1 ? 0 : sectionInset.bottom)
            }
            maps.append(map)
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight)
    }
}

extension WaterFallLayout {
    
    var maxHeight: CGFloat {
        return (maps.last?.values.max() ?? 0)
    }
    
    func minHeightColumn(_ map: [Int: CGFloat]) -> Int? {
        guard let value = map.values.min() else { return nil }
        let columns = map.keys
        for column in columns where map[column] == value {
            return column
        }
        return nil
    }
}
