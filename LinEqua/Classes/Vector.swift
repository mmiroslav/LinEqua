//
//  Vector.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

class Vector: NSObject {

    var vector = [Double]()
    
    
    convenience init(withArray array: Array<Double>) {
        self.init()
        vector = array
    }
    
}


extension Vector {
    
    static func *(lhs: Vector, rhs: Double) -> Vector {
        let newVectorArray = lhs.vector.map { $0 * rhs }
        return Vector(withArray: newVectorArray)
    }
    
    static func ==(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.vector == rhs.vector
    }
    
    static func !=(lhs: Vector, rhs: Vector) -> Bool {
        return !(lhs == rhs)
    }
}
