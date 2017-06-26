//
//  Matrix.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

public class Matrix: NSObject {
    
    private var x: Int = 0
    private var y: Int = 0
    
    private var rows: [Vector] = [Vector]()
    
    override public var description: String {
        return rows.reduce("") { $0 + "\($1)\n" }
    }
    
    
    public init(withRows vectors: [Vector]) {
        rows = vectors
        if vectors.count > 0 {
            x = vectors.count
            y = vectors[0].count
        }
    }
    
    
    public convenience init(withZeroMatrixOfWidth width: Int, height: Int) {
        let vector = Vector(zeroVectorWith: width)
        self.init(withRows: [Vector](repeating: vector, count: height))
    }
    
    
}
