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
        
//        let squareMatrixSample = Constant.SampleData.sampleMatrix4x5
//        let squareMatrixSample = Constant.SampleData.sampleMatrix5x6
//
//        var matrixForGaussianElimination = Matrix(withElements: squareMatrixSample)
//        matrixForGaussianElimination.timeDelegate = self
//        print("determinant: \(matrixForGaussianElimination.determinantRecursive(matrixForGaussianElimination))")
//        print(matrixForGaussianElimination.solveWithGaussian())
//
//        var matrixForGaussJordanElimination = Matrix(withElements: squareMatrixSample)
//        matrixForGaussJordanElimination.timeDelegate = self
//        print(matrixForGaussJordanElimination.solveWithGaussianJordan())
//        
//        print(matrixForGaussianElimination)
        
//        
//        
        let generator = Generator(withSize: Size(x: 200, y: 201))
        var generatedMatrix = generator.generateMatrix()
        generatedMatrix.timeDelegate = self
        print(generatedMatrix)
//        print(generatedMatrix.determinant())
        
        var genMatrixForGJ = generatedMatrix
        var genMatrixForGOnly = generatedMatrix

        _ = genMatrixForGOnly.solveWithGaussian()
        _ = genMatrixForGJ.solveWithGaussianJordan()
        
//        print("Gaussian: \(genMatrixForGOnly.solveWithGaussian())")
//        print("GaussJor: \(genMatrixForGJ.solveWithGaussianJordan())")
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: MatrixTimeMeasureProtocol {
    func timeOfExecutiongGaussian(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Gaussian: \(time)")
    }
    
    func timeOfExecutiongGaussJordan(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Gauss-Jordan: \(time)")
    }
    
    func timeOfDeterminantCalculation(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Determinant calculation: \(time)")
    }
}
