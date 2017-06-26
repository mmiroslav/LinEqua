//
//  Vector.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

public class Vector: NSObject {

    var vector = [Double]()
    
    
    public convenience init(withArray array: Array<Double>) {
        self.init()
        vector = array
    }

    public func printVector() -> String{
        var str = "["
        for elem in vector {
            str.append("\(elem),")
        }
        str.append("]")
        return str
    }
}


extension Vector {
    
    static public func *(lhs: Vector, rhs: Double) -> Vector {
        let newVectorArray = lhs.vector.map { $0 * rhs }
        return Vector(withArray: newVectorArray)
    }
    
    static public func ==(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.vector == rhs.vector
    }
    
    static public func !=(lhs: Vector, rhs: Vector) -> Bool {
        return !(lhs == rhs)
    }
}
