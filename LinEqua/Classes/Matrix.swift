//
//  Matrix.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

public struct Matrix: CustomStringConvertible {
    
    public var size = Size(x: 0, y: 0)
    public var elements: [[Double]] = []
    public var originalValue: [[Double]]?
    
    public var timeDelegate: MatrixTimeMeasureProtocol?
    
    public var isSquare: Bool {
        return size.x == size.y
    }
    
    // MARK: inits
    
    
    public init(withSize size: Size) {
        self.size = size
        self.elements = [[Double]].init(repeating: [Double].init(repeating: 0.0, count: size.y), count: size.x)
        self.originalValue = self.elements
    }
    
    public init(withElements elements: [[Double]]) {
        if elements.count <= 0 {
            fatalError("Matrix with size [0][0] not allowed")
        }
        self.size = Size(x: elements.count, y: elements[0].count)
        self.elements = elements
        self.originalValue = self.elements
    }
    
    public mutating func updateOriginals() {
        self.originalValue = self.elements
    }
    
    // MARK: override vars
    
    public var description: String {
        guard let values = originalValue else { return "[]" }
        return values.reduce("") { $0 + "\($1)\n" }
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
    
    // MARK: determinant
    
    public func determinant() -> Double {
        let time = BlockTime()
        time.startTime()
        
        var det = 0.0
        if elements.count + 1 == elements[0].count {
            var squareMatrix = self
            squareMatrix.removeCollumn(at: squareMatrix.elements[0].count - 1)
            det = determinantRecursive(squareMatrix)
        } else {
            det = determinantRecursive(self)
        }
        
        let duration = time.stopTime()
        print("Duration\(duration)")
        self.timeDelegate?.timeOfDeterminantCalculation(duration: duration, for: self)
        
        return det
    }
    
    /**
     *  Recursive aproach
     */
    public func determinantRecursive(_ matrix: Matrix) -> Double {
        
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
//                print(subMatrix)
//                print("Value: \(value)")
                let prev = determinantRecursive(subMatrix)
                det += value * sign * prev
                sign *= -1.0
//                print(value)
//                print(det)
                
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
    
    
    // MARK: eleimination
    
    public mutating func swapRow(at index1: Int, with index2: Int) {
        let tmpRow = elements[index1]
        elements[index1] = elements[index2]
        elements[index2] = tmpRow
    }
    
    mutating func prepareForElimination() {
        // if 0 is on first position try to swap rows
        if(elements[0][0] == 0) {
            for p in 1..<elements.count {
                if elements[p][0] != 0 {
                    swapRow(at: 0, with: p)
                    break
                }
            }
        }
    }
    
    public mutating func gaussianUpperTriangle() {
        prepareForElimination()
        var matrix = self.elements
        
        // upper triangle
        var pivotRow: [Double] = [Double]()
        var pivot: Double = 0.0
        var mul: Double = 0.0
        for i in 0..<matrix.count-1 {
            pivot = matrix[i][i]
            matrix[i] = matrix[i].map { $0 / pivot }
            for j in i+1..<matrix.count {
                pivotRow = matrix[i]
                
                mul = matrix[j][i]
                pivotRow = pivotRow.map { $0 * mul }
                
                for k in 0..<matrix[j].count {
                    matrix[j][k] -= pivotRow[k]
                }
            }
        }
        let lastRowIndex = matrix.count - 1
        if matrix[lastRowIndex][lastRowIndex] != 0 {
            matrix[lastRowIndex] = matrix[lastRowIndex].map { $0 / matrix[lastRowIndex][lastRowIndex] }
        }
        
        matrix = Matrix.cleanMatrix(matrix, with: Constant.Gaussian.threshold)
        
        self.elements = matrix
    }
    
    
    static func cleanMatrix(_ matrix: [[Double]], with trashold: Double) -> [[Double]] {
        var m = matrix
        guard let numberOfColumns = m.first?.count else { return [[Double]]() }
   
        for i in 0..<m.count {
            for j in 0..<numberOfColumns {
                if abs(m[i][j]) < trashold {
                    m[i][j] = 0
                }
            }
        }
        return m
    }

    
    public func gaussJordan() -> [Double]{
        var matrix = self.elements

        // diagonal only
        var pivotRow: [Double] = [Double]()
        var mul: Double = 0.0
        for i in (1..<matrix.count).reversed() {
            for j in (0..<i).reversed() {
                pivotRow = matrix[i]
                mul = matrix[j][i]
                pivotRow = pivotRow.map { $0 * mul }
                
                for k in 0..<matrix[j].count {
                    matrix[j][k] -= pivotRow[k]
                }
            }
        }
        
        var sol = [Double](repeating: 0.0, count: matrix.count)
        for i in 0..<matrix.count {
            sol[i] = matrix[i].last!
        }
        
        return sol
    }
    
    public func substitute() -> [Double] {
        var matrix = elements
        var sol = [Double](repeating: 0.0, count: matrix.count)
        sol[sol.count - 1] = matrix[matrix.count - 1][matrix.count]
        
        for i in (0..<matrix.count - 1).reversed() {
            var vector: [Double] = matrix[i]
            
            var substract = 0.0
            for k in 0..<sol.count {
                substract += vector[k] * sol[k]
            }
            sol[i] = vector.last! - substract
        }
        
        return sol
    }

}


public extension Matrix {
    
    /**
     * Solve system of linear equations using method of Gaussian eleimination
     *
     */
    public mutating func solveWithGaussian() -> [Double] {
        let time = BlockTime()
        
        if let originals = originalValue {
            elements = originals
        }
        
        time.startTime()
        
        self.gaussianUpperTriangle()
        let results = self.substitute()
        
        let duration = time.stopTime()
        self.timeDelegate?.timeOfExecutiongGaussian(duration: duration, for: self)
        
        return results
    }
    
    
    /**
     * Solve system of linear equations using method of Gauss-Jordan eleimination
     *
     */
    public mutating func solveWithGaussianJordan() -> [Double] {
        let time = BlockTime()
        
        if let originals = originalValue {
            elements = originals
        }
        
        time.startTime()
        
        self.gaussianUpperTriangle()
        let results = self.gaussJordan()
        
        let duration = time.stopTime()
        self.timeDelegate?.timeOfExecutiongGaussJordan(duration: duration, for: self)
        
        return results
    }
}

