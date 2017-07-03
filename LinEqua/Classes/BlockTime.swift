//
//  BlockTime.swift
//  Pods
//
//  Created by Miroslav Milivojevic on 7/3/17.
//
//

import UIKit
import CoreFoundation

class BlockTime  {
    var start: CFAbsoluteTime?
    var stop: CFAbsoluteTime?
    
    var duration: CFAbsoluteTime {
        guard let start = start, let stop = stop else { return 0.0 }
        return stop - start
    }
    
    public func startTime() {
        start = CFAbsoluteTimeGetCurrent()
    }
    
    public func stopTime() -> CFAbsoluteTime {
        stop = CFAbsoluteTimeGetCurrent()
        
        return self.duration
    }
}
