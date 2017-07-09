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
    
    
    func calculateGausError() -> Double {
        guard let resultsGauss = resultsGauss else { return 0.0 }
        let gaussResults = Vector(withArray: resultsGauss)
        var matrix = generatedMatrix ?? insertedMatrix ?? Matrix.init(withSize: Size(x: resultsGauss.count, y: resultsGauss.count + 1)
        matrix
        var ma
        
        
        
        return 0.0
    }
    
    func calculateGausJordanError() -> Double {
        return 0.0
    }
    
}
