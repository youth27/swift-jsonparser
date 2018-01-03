//
//  ResultData.swift
//  JSONParser
//
//  Created by YOUTH on 2018. 1. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultData {
    
    func makeResultData (_ dataType: JSONData) -> String {
        if case let JSONData.ArrayValue(dataType) = dataType {
            var printData = listResult(dataType)
            printData.removeLast()
            return printData
        }
        if case let JSONData.ObjectValue(dataType) = dataType {
            var printData = objectResult(dataType, depth: 1)
            printData.removeLast()
            return printData
        }
        return ""
    }
    
    private func objectResult (_ values: [String:JSONData], depth: Int) -> String {
        var resultText = ""
        resultText += "{"
        resultText += makeNewLine()
        for key in values.keys {
            let valueInObject = values[key] ?? JSONData.IntegerValue(0)
            resultText += makeDepth(depth) + "\(key) : \(String(describing: valueInObject)), "
            resultText += makeNewLine()
        }
        resultText += makeDepth(depth) + "},"
        resultText += makeNewLine()
        return resultText
    }
    
    private func listResult (_ values: [JSONData]) -> String {
        var resultText = ""
        resultText += "["
        for value in values {
            if case let JSONData.ArrayValue(value) = value {
                resultText += nestedList(value, depth: 1)
            }
            if case let JSONData.ObjectValue(value) = value {
                resultText += objectResult(value, depth: 2)
            }
        }
        resultText += "],"
        return resultText
    }
    
    private func nestedList (_ value: [JSONData], depth: Int) -> String {
        var resultText = ""
        resultText += makeDepth(depth)
        resultText += String(describing: value.description)
        resultText += makeNewLine()
        
        return resultText
    }
    
    private func makeDepth(_ depth: Int) -> String{
        return String(repeating: "\t", count: depth)
    }
    
    private func makeNewLine() -> String {
        return "\n"
    }

}
