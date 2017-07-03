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
        guard let begin = start, let end = stop else { return 0.0 }
        return end - begin
    }
    
    public func startTime() {
        start = CFAbsoluteTimeGetCurrent()
    }
    
    public func stopTime() -> CFAbsoluteTime {
        stop = CFAbsoluteTimeGetCurrent()
        
        return self.duration
    }
}
