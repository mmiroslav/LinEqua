//
//  Protocols.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 7/3/17.
//
//

import Foundation

public protocol MatrixTimeMeasureProtocol {
    
    func timeOfExecutiongGaussian(duration time:CFAbsoluteTime, for matrix: Matrix)
    func timeOfExecutiongGaussJordan(duration time:CFAbsoluteTime, for matrix: Matrix)
    
}
