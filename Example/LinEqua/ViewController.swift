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
        
        let squareMatrixSample = Constant.SampleData.sampleMatrix4x5
    
        let matrixForGaussianElimination = Matrix(withElements: squareMatrixSample)
        print(matrixForGaussianElimination.solveWithGaussian())

        let matrixForGaussJordanElimination = Matrix(withElements: squareMatrixSample)
        print(matrixForGaussJordanElimination.solveWithGaussianJordan())
        
        print(matrixForGaussianElimination.description)
        
        
        //////////////////////////////////////////////////////////////////
        //        let startTime = CFAbsoluteTimeGetCurrent()
        //
        //        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        //        print("Time elapsed: \(timeElapsed) s.")
        //////////////////////////////////////////////////////////////////
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

