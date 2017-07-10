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
        let gaussResultsVector = Vector(withArray: resultsGauss)
        guard let matrix = generatedMatrix else {return 0.0}
        
        
        var sumGausErrors = 0.0
        for row in matrix.elements {
            let rowVector = Vector(withArray: row)
            let result = rowVector.popLast()
            sumGausErrors += result! - (rowVector * gaussResultsVector).sum()
            
        }
        let rv = sumGausErrors / Double(gaussResultsVector.count)
        print("Gauss error: \(rv)")
        return abs(rv)
    }
    
    func calculateGausJordanError() -> Double {
        guard let resultsGauss = resultsGaussJordan else { return 0.0 }
        let gaussJordanResultsVector = Vector(withArray: resultsGauss)
        guard let matrix = generatedMatrix else {return 0.0}
        
        
        var sumGausJordanErrors = 0.0
        for row in matrix.elements {
            let rowVector = Vector(withArray: row)
            let result = rowVector.popLast()
            sumGausJordanErrors += result! - (rowVector * gaussJordanResultsVector).sum()
            
        }
        let rv = sumGausJordanErrors / Double(gaussJordanResultsVector.count)
        print("Gauss Jordan error: \(rv)")
        return abs(rv)
    }
    
}
