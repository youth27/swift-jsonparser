//
//  ValueCounter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ValueCounter {
    
    func checkTypeOfValue (_ values: [String]) -> CountingInfo {
        var intNum: Int = 0
        var stringNum: Int = 0
        var boolNum: Int = 0
        var valueList : [AnyObject] = []
        
        for value in values {
            if let boolValue = Bool(value) {
                valueList.append(boolValue as AnyObject)
                boolNum += 1
                continue
            } else if let intValue = Int(value) {
                valueList.append(intValue as AnyObject)
                intNum += 1
                continue
            }
                valueList.append(value as AnyObject)
                stringNum += 1
        }
        let valueNum = valueList.count
        return CountingInfo(valueNum, intNum, stringNum, boolNum)
    }
    
}
