//
//  ViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 06/26/2017.
//  Copyright (c) 2017 Miroslav Milivojevic. All rights reserved.
//

import UIKit
import LinEqua
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var noOfUnknowns: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderPercentage: UILabel!
    @IBOutlet weak var dataTypeSegments: UISegmentedControl!
    
    @IBOutlet weak var statsViewContainer: UIView!
    @IBOutlet weak var gaussTimeLabel: UILabel!
    @IBOutlet weak var gaussJordanTimeLabel: UILabel!
    @IBOutlet weak var gaussHeight: NSLayoutConstraint!
    @IBOutlet weak var gausJordanHeight: NSLayoutConstraint!
    
    @IBOutlet weak var gausErrorLabel: UILabel!
    @IBOutlet weak var gausJordanErrorLabel: UILabel!
    @IBOutlet weak var gaussErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var gausJordanErrorHight: NSLayoutConstraint!
    
    @IBOutlet weak var resultsStackView: UIStackView!
    
    let generator = Generator()
    var matrix = Matrix(withSize: Size.zero)
    
    var gaussianSolution: [Double]?
    var gaussJordanSolution: [Double]?
    var _gaussTime: Double?
    var _gaussJordanTime: Double?
    var _gaussCompError: Double?
    var _gaussJordanCompError: Double?
    
    var gaussTime: Double? {
        get {
            return _gaussTime
        }
        set {
            _gaussTime = newValue
            gaussTimeLabel.text = String(format: "%.4f", _gaussTime ?? 0.0)
            setupTimeBars()
        }
    }
    var gaussJordanTime: Double? {
        get {
            return _gaussJordanTime
        }
        set {
            _gaussJordanTime = newValue
            gaussJordanTimeLabel.text = String(format: "%.4f", _gaussJordanTime ?? 0.0)
            setupTimeBars()
        }
    }
    
    var gausComputingError: Double? {
        get {
            return _gaussCompError
        }
        set {
            _gaussCompError = newValue
            gausErrorLabel.text = String(format: "%.4f", (_gaussCompError ?? 00) * 10_000_000_000)
            setupErrorBars()
        }
    }
    
    var gausJordanComputingError: Double? {
        get {
            return _gaussJordanCompError
        }
        set {
            _gaussJordanCompError = newValue
            gausJordanErrorLabel.text = String(format: "%.4f", (_gaussJordanCompError ?? 00) * 10_000_000_000)
            setupErrorBars()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        matrix.timeDelegate = self
        setupTimeBars()
        
        if !UIDevice.current.isBatteryMonitoringEnabled {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
        
        print(UIDevice.current.batteryLevel)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let matrix = Data.shared.matrix {
            self.matrix = matrix
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTimeToZero() {
        gaussTime = 0.0
        gaussJordanTime = 0.0
    }
    
    func setErrorToZero() {
        gausComputingError = 0.0
        gausJordanComputingError = 0.0
    }
    
    func generateMatrix() -> Bool {
        guard let unknownsCountText = noOfUnknowns.text else { return false }
        guard let unknownsCount = Int(unknownsCountText) else { return false }
        
        generator.setSize(Size(x: unknownsCount, y: unknownsCount + 1))
        generator.setZero(volume: Double(slider.value))
        matrix = generator.generateMatrix()
        matrix.timeDelegate = self
        
        Data.shared.generatedMatrix = matrix
        print(matrix)
        
        
        return true
    }
    
    func setupTimeBars() {
        let baseHeight = 16.0
        let gaussT = gaussTime ?? 0.0
        let gaussJordanT = gaussJordanTime ?? 0.0
        
        let maxTime = max(gaussT, gaussJordanT)
        if maxTime != 0 {
            gaussHeight.constant = CGFloat(gaussT / maxTime * 100.0 + baseHeight)
            gausJordanHeight.constant = CGFloat(gaussJordanT / maxTime * 100.0 + baseHeight)
        } else {
            gaussHeight.constant = CGFloat(baseHeight)
            gausJordanHeight.constant = CGFloat(baseHeight)
        }
    }
    
    func setupErrorBars() {
        let baseHeight = 16.0
        let gaussE = gausComputingError ?? 0.0
        let gaussJordanE = gausJordanComputingError ?? 0.0
        
        let maxError = max(gaussE, gaussJordanE)
        if maxError != 0 {
            gaussErrorHeight.constant = CGFloat(gaussE / maxError * 100.0 + baseHeight)
            gausJordanErrorHight.constant = CGFloat(gaussJordanE / maxError * 100.0 + baseHeight)
        } else {
            gaussErrorHeight.constant = CGFloat(baseHeight)
            gausJordanErrorHight.constant = CGFloat(baseHeight)
        }

    }
}

extension ViewController {
    
    @IBAction func sliderChange(_ sender: UISlider) {
        sliderPercentage.text = "\(Int(sender.value * 100.0))%"
    }

    @IBAction func calculateGaussian() {
        setTimeToZero()
        setErrorToZero()
        MBProgressHUD.showAdded(to: resultsStackView, animated: true)
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.shared.matrix != nil {
                self.gaussianSolution = self.matrix.solveWithGaussian()
                Data.shared.resultsGauss = self.gaussianSolution
                Data.shared.resultsGaussJordan = nil
            }
            DispatchQueue.main.async {
                self.gausComputingError = Data.shared.calculateGausError()
                MBProgressHUD.hide(for: self.resultsStackView, animated: true)
            }
        }
        
    }

    @IBAction func calculateGaussJordan() {
        setTimeToZero()
        setErrorToZero()
        MBProgressHUD.showAdded(to: resultsStackView, animated: true)
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.shared.matrix != nil {
                self.gaussJordanSolution = self.matrix.solveWithGaussianJordan()
                Data.shared.resultsGaussJordan = self.gaussJordanSolution
                Data.shared.resultsGauss = nil
            }
            DispatchQueue.main.async {
                self.gausJordanComputingError = Data.shared.calculateGausJordanError()
                MBProgressHUD.hide(for: self.resultsStackView, animated: true)
            }
            
        }
    }

    @IBAction func calculateBoth() {
        setTimeToZero()
        setErrorToZero()
        MBProgressHUD.showAdded(to: resultsStackView, animated: true)
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.shared.matrix != nil {
                self.gaussianSolution = self.matrix.solveWithGaussian()
                self.gaussJordanSolution = self.matrix.solveWithGaussianJordan()
                Data.shared.resultsGauss = self.gaussianSolution
                Data.shared.resultsGaussJordan = self.gaussJordanSolution
            }
            DispatchQueue.main.async {
                self.gausComputingError = Data.shared.calculateGausError()
                self.gausJordanComputingError = Data.shared.calculateGausJordanError()
                MBProgressHUD.hide(for: self.resultsStackView, animated: true)
            }
        }
    }

    @IBAction func showMatrix() {
    }
    
    
    @IBAction func generateMatrixAction() {
        MBProgressHUD.showAdded(to: resultsStackView, animated: true)
        DispatchQueue.global(qos: .userInteractive).async {
            _ = self.generateMatrix()
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.resultsStackView, animated: true)
            }
        }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        noOfUnknowns.resignFirstResponder()
    }
}


extension ViewController: MatrixTimeMeasureProtocol {
    func timeOfExecutiongGaussian(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Gaussian: \(time)")
        DispatchQueue.main.sync {
            gaussTime = time
        }
        
    }
    
    func timeOfExecutiongGaussJordan(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Gauss-Jordan: \(time)")
        DispatchQueue.main.sync {
            gaussJordanTime = time
        }
    }
    
    func timeOfDeterminantCalculation(duration time: CFAbsoluteTime, for matrix: Matrix) {
        print("Time for Determinant calculation: \(time)")
    }
}

