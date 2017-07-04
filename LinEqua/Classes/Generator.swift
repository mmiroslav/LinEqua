//
//  Generator.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 7/3/17.
//
//

import UIKit

public class Generator: NSObject {
    var size: Size
    var zeroVolume: Double = 0.12
    
    public override init() {
        self.size = Size.zero
    }
    
    public init(withSize size: Size) {
        self.size = size
    }
    
    public func setSize(_ size: Size) {
        self.size = size
    }
    
    public func setZero(volume: Double) {
        self.zeroVolume = volume
    }
    
    public func generateMatrix() -> Matrix {
        var matrix = Matrix(withSize: size)
    
        repeat {
            for i in 0..<size.x {
                for j in 0..<size.y {
                    matrix.elements[i][j] = Double(randomNumberInRange(from: 0, to: 30))
                }
            }
        } while matrix.determinant() == 0.0
        
        matrix.updateOriginals()
        return matrix
    }
    
    func randomNumberInRange(from: Int, to: Int) -> Int {
        let zeroMatch = arc4random_uniform(100)
        if Double(zeroMatch) < self.zeroVolume * 100 {
            return 0
        }
        
        return Int(arc4random_uniform(UInt32(to - from)) + UInt32(from))
    }
}
