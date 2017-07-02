//
//  ViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 06/26/2017.
//  Copyright (c) 2017 Miroslav Milivojevic. All rights reserved.
//

import UIKit
import LinEqua


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let a: Vector = Vector()
        let b: Vector = Vector(withArray: [1,1,2,3,5,8])
        
        print(b)
        let c = b * 3.0
        print(c)
        if a == b {
            print("a == b")
        }
        
        
        let aa = Vector(withArray: [1,2,1])
        let bb = Vector(withArray: [1,2,1])
        
        
        if aa == bb {
            print("aa==bb")
        }
        
        
//        let matr: Matrix = Matrix(withZeroMatrixOfWidth: 3, height: 4)
        let size = Size(x: 3, y: 4)
        var matr = Matrix(withSize: size)
        print("\(matr)")
        
        _ = matr.transpose()
        
        print("\(matr)")
        
        let mtxSample = [
            [0.0,1.0,2.0,3.0],
            [4.0,5.0,6.0,7.0],
            [8.0,9.0,10.0,11.0]
        ]
        
        var newmtx = Matrix(withElements: mtxSample)
        
        _ = newmtx
        print(newmtx)
//        _ = newmtx.transpose()
        newmtx.removeRow(at: 1)
        print(newmtx)
        newmtx.removeCollumn(at: 2)
        print(newmtx)
        
//        print(detMatrix.determinant(detMatrix))
        

        let squareMAtrixSample = [
            [8.0,  2.0,  3.0,  4.0,  13.0],
            [5.0,  6.0,  7.0,  8.0,  23.0],
            [11.0, 18.0, 11.0, 12.0, 45.0],
            [13.0, 17.0,  15.0, 16.0, 78.0],
        ]
        
        
        
        
        var sqMatrix = Matrix(withElements: squareMAtrixSample)
        print(sqMatrix)
        let det = sqMatrix.determinant(sqMatrix)
        print(det)
        
        var newGausElemMAtrix = Matrix(withElements: squareMAtrixSample)
        
        print(newGausElemMAtrix.description)
        newGausElemMAtrix.gaussianUpperTriangle()
        print(newGausElemMAtrix.description)
        
        print(newGausElemMAtrix.substitute())
        print(newGausElemMAtrix.gaussJordan(forGaussUpperMatrix: newGausElemMAtrix))
        
//        var sum = 0.0
//        for i in 0..<newGausElemMAtrix.elements.count {
//            sum += newGausElemMAtrix.elements[i][newGausElemMAtrix.elements.count] * squareMAtrixSample[0][i]
//            print("\(sum) = \(newGausElemMAtrix.elements[i][newGausElemMAtrix.elements.count]) * \(squareMAtrixSample[0][i])")
//        }
//        
//        print(sum)
        
//        newGausElemMAtrix.gau
        
//        let gaus = sqMatrix.gaussian(matrix: sqMatrix)
//        print(gaus)
        
        
//        sqMatrix.upperTriangle()
//        print(sqMatrix.description)
//        
//        print(Matrix.determinantForTriangleMatrix(sqMatrix))
//        print(sqMatrix.determinant(sqMatrix))
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

