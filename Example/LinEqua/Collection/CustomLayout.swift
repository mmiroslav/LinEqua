//
//  CustomLayout.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {

    let CELL_WIDTH = 50.0
    let CELL_HEIGHT = 50.0
    
    var cellAttrsDictionary: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    var contentSize: CGSize = CGSize.zero
    
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func prepare() {
        guard let numOfSections = collectionView?.numberOfSections, numOfSections > 0  else { return }
        for section in 0..<numOfSections {
            guard let numOfItems = collectionView?.numberOfItems(inSection: section), numOfItems > 0 else { return }
            for item in 0..<numOfItems {
                let cellIndex = IndexPath(item: item, section: section)
                let xPos = Double(item) * CELL_WIDTH
                let yPos = Double(section) * CELL_HEIGHT
                
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: CELL_WIDTH, height: CELL_HEIGHT)
                cellAttributes.zIndex = 1
                
                cellAttrsDictionary[cellIndex] = cellAttributes
            }
        }
        
        let contentWidth = Double(collectionView!.numberOfItems(inSection: 0)) * CELL_WIDTH
        let contentHeight = Double(collectionView!.numberOfSections) * CELL_HEIGHT
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for cellAttributes in Array(cellAttrsDictionary.values) {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        return attributesInRect
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false 
    }
    
    
}
