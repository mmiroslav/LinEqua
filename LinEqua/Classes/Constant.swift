//
//  Constant.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 7/3/17.
//
//

import Foundation

public struct Constant {
    
    public struct Gaussian {
        public static let threshold: Double = 0.0000000001
    }
    
    public struct SampleData {
        public static let sampleMatrix4x5 =  [
            [8.0,  2.0,  3.0,  4.0,  13.0],
            [5.0,  6.0,  7.0,  8.0,  23.0],
            [11.0, 18.0, 11.0, 12.0, 45.0],
            [13.0, 17.0, 15.0, 16.0, 78.0],
        ]
        
        public static let sampleMatrix5x6 =  [
            [8.0,  2.0,  3.0,  4.0,  3.0,  13.0],
            [5.0,  6.0,  7.0,  8.0,  1.0,  23.0],
            [11.0, 18.0, 11.0, 12.0, 2.0,  45.0],
            [13.0, 17.0, 15.0, 16.0, 1.0,  78.0],
            [3.0,  2.0,  4.0,  3.0,  1.0,  12.0],
        ]
    }
}
