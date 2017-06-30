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
    
    
    
    public mutating func upperTriangle() {
        var newMatrix = self
        guard let matrixWidth = newMatrix.elements.first?.count else { return }
        let matrixHeight = newMatrix.elements.count
        
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
    
    
    // MARK: determinant
    
    /**
     *  Recursive aproach
     */
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
    
    public static func determinantForTriangleMatrix(_ matrix: Matrix) -> Double {
        guard let firstElem = matrix.elements.first?.first else { return 0.0 }
        var det = firstElem
        for i in 1..<matrix.elements.count {
            det *= matrix.elements[i][i]
        }
        return det
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
    
    
    public func gaussian(matrix mtx: Matrix) -> Matrix {
        var matrix = mtx
        
        var id = Matrix(withSize: self.size)
        var rowExchange = 0
        
        for j in 0..<(matrix.elements.first?.count)! * 2 {
            for i in j - rowExchange..<matrix.elements.count {
                let pivot = matrix.elements[j - rowExchange][j - rowExchange]
                if pivot == 0 {
                    let holdingMat = matrix.elements[i]
                    matrix.elements[i] = matrix.elements[i + 1]
                    matrix.elements[i + 1] = holdingMat
                    
                    let holdingID = id.elements[i]
                    id.elements[i] = id.elements[i + 1]
                    id.elements[i + 1] = holdingID
                    rowExchange += 1
                    break
                }
                var factor = matrix.elements[i + 1][j - rowExchange] / pivot
                
                for k in 0..<(matrix.elements.first?.count)! {
                    matrix.elements[i + 1][k] -= factor * matrix.elements[j - rowExchange][k]
                    id.elements[i + 1][k] -= factor * id.elements[j - rowExchange][k]
                }
                if i + 1 >= matrix.elements.count - 1 {
                    break
                }
            }
            if j - rowExchange + 1 >= (matrix.elements.first?.count)! - 1 {
                break
            }
        }
        return id        
    }

}
