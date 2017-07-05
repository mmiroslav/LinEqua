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
    
    var matrix: Matrix?
    var generatedMatrix: Matrix?
    
    var resultsGauss: [Any]? = []
    var resultsGaussJordan: [Any]? = []
    
    private override init() {}
    
    
}
