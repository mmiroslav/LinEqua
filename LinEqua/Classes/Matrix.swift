//
//  Matrix.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

public struct Matrix {
    
    public var size = Size(x: 0, y: 0)
    public var elements: [[Double]] = []
    
    public var isSquare: Bool {
        return size.x == size.y
    }
    
    // MARK: inits
    
    
    public init(withSize size: Size) {
        self.size = size
        elements = [[Double]].init(repeating: [Double].init(repeating: 0.0, count: size.y), count: size.x)
    }
    
    public init(withElements elements: [[Double]]) {
        if elements.count <= 0 {
            fatalError("Matrix with size [0][0] not allowed")
        }
        self.size = Size(x: elements.count, y: elements[0].count)
        self.elements = elements
    }
    
    // MARK: override vars
    
    public var description: String {
        return elements.reduce("") { $0 + "\($1)\n" }
    }
    
    //MARK: functionalities
    
    public mutating func transpose() -> Matrix {
        var transponed = Matrix(withSize: Size(x: size.y, y: size.x))
        for i in 0..<size.y {
            for j in 0..<size.x {
                transponed.elements[i][j] = self.elements[j][i]
            }
        }
        self.elements = transponed.elements
        return self
    }
    
    
    
    public func determinant(_ matrix: Matrix) -> Double {
        if matrix.elements.first?.count == 1 {
            print("single matrix \(matrix)")
            return (matrix.elements.first?.first)!
        } else {
            
            var det = 0.0
            var sign = 1.0
            
            guard let firstRow = matrix.elements.first else { return 0.0 }
            
            for (column, value) in firstRow.enumerated() {
                var subMatrix = matrix
                print(subMatrix)
                subMatrix.removeRow(at: 0)
                subMatrix.removeCollumn(at: column)
                print(subMatrix)
                det += value * sign * determinant(subMatrix)
                print("det: \(det)")
                sign *= -1.0
            }
            
            return det
        }
    }
    
    
    public mutating func removeRow(at index: Int) {
        if index >= elements.count {
            fatalError("Unexpected index")
        }
        elements.remove(at: index)
        size = Size(x: size.x - 1, y: size.y)
    }
    
    public mutating func removeCollumn(at index: Int) {
        if let count = elements.first?.count, index >= count {
            fatalError("Unexpected index")
        }
        var newMatrix = [[Double]]()
        for var elem in elements {
            elem.remove(at: index)
            newMatrix.append(elem)
        }
        elements = newMatrix
        size = Size(x: size.x, y: size.y - 1)
    }
    
}
