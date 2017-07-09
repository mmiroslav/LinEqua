//
//  Matrix.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 6/26/17.
//
//

import UIKit

public struct Matrix: CustomStringConvertible {
    
    public var size = Size.zero
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
    
    public mutating func updateValues() {
        self.elements = self.originalValue!
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
    
    public mutating func determinant() -> Double {
        updateOriginals()
        gaussianUpperTriangle()
        let det =  Matrix.determinantForTriangleMatrix(self)
        updateValues()
        return det
    }
    
    /**
     *  Recursive approach
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
                
                let prev = determinantRecursive(subMatrix)
                det += value * sign * prev
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
    
    
    mutating func removeRow(at index: Int) {
        if index >= elements.count {
            fatalError("Unexpected index")
        }
        elements.remove(at: index)
        size = Size(x: size.x - 1, y: size.y)
    }
    
    mutating func removeCollumn(at index: Int) {
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
    
    mutating func swapRow(at index1: Int, with index2: Int) {
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
    
    mutating func gaussianUpperTriangle() {
        prepareForElimination()
        var matrix = self.elements
        
        // upper triangle
        var pivotRow: [Double] = [Double]()
        var pivot: Double = 0.0
        var mul: Double = 0.0
        for i in 0..<matrix.count-1 {
            pivot = matrix[i][i]
            if pivot != 0.0 {
                matrix[i] = matrix[i].map { $0 / pivot }
            }
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

    func substitute() -> [Double] {
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
    
    
    mutating func gaussJordan() -> [Double] {
        prepareForElimination()
        var results = columnAt(index: elements.count)
        var resultsPivot = 0.0
        removeCollumn(at: elements.count)
        var matrix = self.elements
        
        var pivotRow: [Double] = [Double]()
        var pivot: Double = 0.0
        var mul: Double = 0.0
        for i in 0..<matrix.count {
            pivot = matrix[i][i]
            matrix[i] = matrix[i].map { $0 / pivot }
            results[i] = results[i] / pivot
            for j in 0..<matrix.count {
                if j == i { continue }
                pivotRow = matrix[i]
                
                mul = matrix[j][i]
                pivotRow = pivotRow.map { $0 * mul }
                resultsPivot = results[i] * mul
                
                for k in 0..<matrix[j].count {
                    matrix[j][k] -= pivotRow[k]
                }
                results[j] -= resultsPivot
            }
        }
        return results
    }
    
    
    func columnAt(index: Int) -> [Double] {
        var column = [Double](repeating: 0.0, count: elements.count)
        if elements[0].count < index { return column }
        
        for (i, row) in elements.enumerated() {
            column[i] = row[index]
        }
        
        return column
    }

}


public extension Matrix {
    
    /**
     * Solve system of linear equations 
     * using method of Gaussian elimination
     */
    public mutating func solveWithGaussian() -> [Double] {
        let time = BlockTime()
        
        if let originals = originalValue {
            elements = originals
        }
        
        time.startTime()
        
        self.gaussianUpperTriangle()
        let results = self.substitute()
        print(results)
        
        let duration = time.stopTime()
        self.timeDelegate?.timeOfExecutiongGaussian(duration: duration, for: self)
        
        return results
    }
    
    
    /**
     * Solve system of linear equations 
     * using method of Gauss-Jordan elimination
     */
    public mutating func solveWithGaussianJordan() -> [Double] {
        let time = BlockTime()
        
        if let originals = originalValue {
            elements = originals
        }
        
        time.startTime()
        
        let results = self.gaussJordan()
        print(results)
        
        let duration = time.stopTime()
        self.timeDelegate?.timeOfExecutiongGaussJordan(duration: duration, for: self)
        
        return results
    }
}

