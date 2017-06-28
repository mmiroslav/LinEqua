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
            return (matrix.elements.first?.first)!
        } else {
            var det = 0.0
            var sign = 1.0
            
            guard let firstRow = matrix.elements.first else { return 0.0 }
            for (column, value) in firstRow.enumerated() {
                var subMatrix = matrix
                subMatrix.removeRow(at: 0)
                subMatrix.removeCollumn(at: column)
                det += value * sign * determinant(subMatrix)
                sign *= -1.0
            }
            return det
        }
    }
    
    
    public mutating func upperTriangle() {
        var newMatrix = self
        guard let matrixWidth = newMatrix.elements.first?.count else { return }
        let matrixHeight = newMatrix.elements.count
        
//        var newRow = [Double](repeating: 0, count: matrixWidth)
        
//        for i in 0..<matrixHeight {
//            for j in i+1..<matrixWidth {
//                for k in 0..<matrixWidth {
//                    let v1 = newMatrix.elements[i][k] //r0
//                    let v2 = newMatrix.elements[j][i] //r1[0]
//                    let v3 = newMatrix.elements[j][k] //r1
//                    newRow[k] = v1 * (-v2 / v1) + v3
//                }
//                newMatrix.elements[j] = newRow
//            }
//        }
        
        for p in 0..<(matrixHeight) {
            for i in p..<(matrixHeight) {
                for j in i+1..<matrixHeight {
                    let newRowI = mulArray(newMatrix.elements[i], with: -newMatrix.elements[j][i] / newMatrix.elements[i][i] )
                    var newRowJ = [Double](repeating: 0, count: matrixWidth)
                    for (index,v) in newMatrix.elements[j].enumerated() {
                        newRowJ[index] = v + newRowI[index]
                    }
                    newMatrix.elements[j] = newRowJ
                    print(newMatrix.description)
                }
            }
        }
        
        elements = newMatrix.elements
    }
    
    func mulArray(_ array: [Double], with x: Double) -> [Double] {
        return array.map { $0 * x }
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
