//
//  Vector.swift
//  Pods
//
//  Created by Miroslav Milivojevic
//
//

import UIKit

public class Vector: NSObject {

    private var elements = [Double]()
    
    public var elementsArray: [Double] {
        return self.elements
    }
    
    public var count: Int {
        return elements.count
    }

    override public var description: String {
        return elements.description
    }
    
    // MARK: inits
    
    public convenience init(withArray array: Array<Double>) {
        self.init()
        self.elements = array
    }
    
    public convenience init(zeroVectorWith dimension: Int) {
        self.init()
        self.elements = [Double](repeating: 0.0, count: dimension)
    }
    
    public func sum() -> Double {
        return elements.reduce(0, +)
    }
}


extension Vector {
    
    static public func *(lhs: Vector, rhs: Double) -> Vector {
        let newVectorArray = lhs.elementsArray.map { $0 * rhs }
        return Vector(withArray: newVectorArray)
    }
    
    static public func +(lhs: Vector, rhs: Vector) -> Vector {
        var newVectorArray = [Double](repeating: 0.0, count: lhs.count)
        for i in 0..<lhs.count {
            newVectorArray[i] = lhs.elementsArray[i] + rhs.elementsArray[i]
        }
        return Vector(withArray: newVectorArray)
    }
    
    static public func *(lhs: Vector, rhs: Vector) -> Vector {
        var newVectorArray = [Double](repeating: 0.0, count: lhs.count)
        for i in 0..<lhs.count {
            newVectorArray[i] = lhs.elementsArray[i] * rhs.elementsArray[i]
        }
        return Vector(withArray: newVectorArray)
    }
    
    static public func ==(lhs: Vector, rhs: Vector) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        
        for i in 0..<lhs.count {
            if lhs.elementsArray[i] != rhs.elementsArray[i] {
                return false
            }
        }
        return true
    }
    
    static public func !=(lhs: Vector, rhs: Vector) -> Bool {
        return !(lhs == rhs)
    }
}
