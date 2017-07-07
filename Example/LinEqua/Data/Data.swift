//
//  Data.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import LinEqua

class Data: NSObject {
    static let shared = Data()
    
    var matrix: Matrix? {
        if insertedMatrix != nil {
            return insertedMatrix
        }
        return generatedMatrix
    }
    
    var generatedMatrix: Matrix?
    var insertedMatrix: Matrix?
    
    var resultsGauss: [Double]? = []
    var resultsGaussJordan: [Double]? = []
    
    private override init() {}
    
    
}
