//
//  InputMatrixViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import LinEqua

class InputMatrixViewController: UIViewController {

    
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var input3: UITextField!
    
    @IBOutlet weak var input4: UITextField!
    @IBOutlet weak var input5: UITextField!
    @IBOutlet weak var input6: UITextField!
    
    @IBOutlet weak var input7: UITextField!
    @IBOutlet weak var input8: UITextField!
    @IBOutlet weak var input9: UITextField!
    
    @IBOutlet weak var res1: UITextField!
    @IBOutlet weak var res2: UITextField!
    @IBOutlet weak var res3: UITextField!
    
    
    var matrix: [[Double]] {
        get {
            return [
                [
                    valueFromInput(input1),
                    valueFromInput(input2),
                    valueFromInput(input3),
                    valueFromInput(res1),
                    ],
                [
                    valueFromInput(input4),
                    valueFromInput(input5),
                    valueFromInput(input6),
                    valueFromInput(res2),
                    ],
                [
                    valueFromInput(input7),
                    valueFromInput(input8),
                    valueFromInput(input9),
                    valueFromInput(res3),
                    ],
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = Data.shared.insertedMatrix?.elements {
            matrixValue(data[0][0], to: input1)
            matrixValue(data[0][1], to: input2)
            matrixValue(data[0][2], to: input3)
            matrixValue(data[0][3], to: res1)
            
            matrixValue(data[1][0], to: input4)
            matrixValue(data[1][1], to: input5)
            matrixValue(data[1][2], to: input6)
            matrixValue(data[1][3], to: res2)
            
            matrixValue(data[2][0], to: input7)
            matrixValue(data[2][1], to: input8)
            matrixValue(data[2][2], to: input9)
            matrixValue(data[2][3], to: res3)
        }
        
        
        input1.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeModal() {
        let det = matrixDeterminant()
        if det == 0.0 {
            let alert = createAlertForDeterminant(det)
            self.present(alert, animated: true, completion: nil)
        } else {
            updateMatixinData()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func updateMatixinData() {
        Data.shared.insertedMatrix = Matrix(withElements: matrix)
    }
    
    func valueFromInput(_ input: UITextField) -> Double {
        var rv: Double = 0.0
        if let text = input.text, text != "" {
            rv = Double(text) ?? 0.0
        }
        return rv
    }

    func matrixValue(_ value: Double, to input: UITextField) {
        input.text = "\(value)"
    }
    
    @IBAction func clearMatrix() {
        Data.shared.insertedMatrix = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkDeterminant() {
        let det = self.matrixDeterminant()
        
        let alert = createAlertForDeterminant(det)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createAlertForDeterminant(_ det: Double) -> UIAlertController {
        let alertController = UIAlertController(title: "Determinant", message: "System determinant is: \(det)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    
    func matrixDeterminant() -> Double {
        var matr = Matrix(withElements: matrix)
        return matr.determinant()
    }
}
