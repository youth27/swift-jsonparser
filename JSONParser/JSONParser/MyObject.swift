//
//  MyObject.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyObject: ParseTarget {
    let JSONFactory = JSONDataFactory()
    var myObject: String
    
    init (_ stringValues: String) {
        myObject = stringValues
    }
    
    func makeMyType() -> ConvertTarget {
        let targetObject = ParseTargetFactory.setTargetToObject(myObject)
        return targetObject
    }
    
   func makeJSONDataValues () -> JSONData {
        let objectInString = makeMyType()
        return JSONFactory.makeConvertedData(objectInString)    }
    
}
