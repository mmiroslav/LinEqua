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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

