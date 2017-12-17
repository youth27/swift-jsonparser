//
//  MyObject.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyObject: ParsingTarget {
    var myObject: String
    let JSONFactory = JSONDataFactory()
    
    init (_ stringValues: String) {
        myObject = stringValues
    }
    
    func makeMyType() -> Dictionary<String,String> {
        let targetObject = ParsingTargetFactory.setTargetToObject(myObject)
        return targetObject
    }

    
    func makeJSONDataValues () -> Dictionary<String,JSONData> {
        let objectInString = makeMyType()
        return JSONFactory.matchValueOfObject(objectInString)
    }
    
}
