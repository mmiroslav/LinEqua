//
//  SampleCollectionViewCell.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
class SampleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SampleCollectionViewCell"
    
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
    }

}
