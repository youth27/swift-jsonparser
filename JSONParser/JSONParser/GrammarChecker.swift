//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation


struct GrammarChecker {
    
    let arrayPattern = "true|false|\".+?\"|(\\d+)|(\\[[^\\[\\]]*\\])|(\\{[^\\{\\}]*\\})"
    let objectPattern = "(\".+?\")\\:(true|false|\\\".+?\\\"|\\d+|\\[.+?\\])"
    let arrayValuePattern = "true|false|(\\d+)|\".+?\"|(\\[[^\\[\\]]*\\])|(\\{[^\\{\\}]*\\})"
    let objectValuePattern = "(\".*\"):((true|false)|(\\{.*\\})|(\\d+)|(\".*\")|(\\[.*\\]))"
    let nestedArrayPattern = "true|false|\".+?\"|(\\d+)"

    enum FormatError: Error, CustomStringConvertible {
        case invalidArray
        case invalidObject
        case invalidInput
        
        var description: String {
            switch self {
            case .invalidArray:
                return "지원하지 않는 배열 형식입니다."
            case .invalidObject:
                return "지원하지 않는 객체 형식입니다."
            case .invalidInput:
                return "지원하지 않는 입력 형태입니다."

            }
        }
    }
    
    func removeBrackets(_ input: String) -> String{
        var trimString = input
        trimString.removeFirst()
        trimString.removeLast()
        return trimString
    }
    
    func execute (_ userInput: String?) throws -> ([String],Parser.ParseTarget) {
        let input = userInput ?? ""
        
        if input.hasPrefix("[") && input.hasSuffix("]") {
            if isValidArray(input) {
                return (extractArrayValue(input: removeBrackets(input), regexPattern: arrayPattern),Parser.ParseTarget.list)
            } else {
                throw GrammarChecker.FormatError.invalidArray
            }
        }
        if input.hasPrefix("{") && input.hasSuffix("}") {
            if isValidObject(input) {
               return (extractObjectValue(input),Parser.ParseTarget.object)
            } else {
                throw GrammarChecker.FormatError.invalidObject
            }
        }
        throw GrammarChecker.FormatError.invalidInput
    }

    // MARK: Array Check
    
    // #1. Array - format check
    private func extractArrayValue (input: String, regexPattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            let nsInput = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: nsInput.length))
            let matchValues = matches.map{nsInput.substring(with: $0.range)}
            return matchValues
        } catch {
            return []
        }
    }
    
    // #2. Array - value check
    private func isValidValueInArray (_ value: String) -> Bool {
        var matchValue = [String]()
        do {
            let regex = try NSRegularExpression(pattern: arrayValuePattern)
            let nsInput = value as NSString
            let matches = regex.matches(in: value, range: NSRange(location: 0, length: nsInput.length))
            matchValue = matches.map{nsInput.substring(with: $0.range)}
        } catch {
            matchValue = []
        }
        return !matchValue.isEmpty
    }
    
    // Array - #1, #2 execute
    func isValidArray (_ input: String) -> Bool {
        let formatMatchValues = extractArrayValue(input: removeBrackets(input), regexPattern: arrayPattern)
        for value in formatMatchValues {
            return isValidValueInArray(value)
        }
        return false
    }

    // MARK: Object Check
    
    // #1. Object - format Check
    private func extractObjectValue (_ input: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: objectPattern)
            let inputInNS = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: inputInNS.length))
            let matchValues = matches.map{inputInNS.substring(with: $0.range)}
            return matchValues
        } catch {
            return []
        }
    }

    // 2. Object - value check
    private func isValidValueinObject (_ value: String) -> Bool {
        var matchValue = [String]()
        do {
            let regex = try NSRegularExpression(pattern: objectValuePattern)
            let inputInNS = value as NSString
            let matches = regex.matches(in: value, range: NSRange(location: 0, length: inputInNS.length))
            matchValue = matches.map{inputInNS.substring(with: $0.range)}
        } catch {
            matchValue = []
        }
        return !matchValue.isEmpty
    }
    
    // Object - #1, #2 execute
    func isValidObject (_ input: String) -> Bool {
        let formatMatchValues = extractObjectValue(input)
        for value in formatMatchValues {
            return isValidValueinObject(value)
        }
        return false
    }
    
    // MARK: Nested Array Check
    
    func forNestedArray (_ input: String) throws -> ([String],Parser.ParseTarget) {
        if isValidNestedArray(input) {
            return (extractArrayValue(input: input, regexPattern: nestedArrayPattern),Parser.ParseTarget.list)
        } else {
            throw GrammarChecker.FormatError.invalidArray
        }
    }
    
    private func isValidNestedArray (_ input: String) -> Bool {
        let formatMatchValues = extractArrayValue(input: input, regexPattern: nestedArrayPattern)
        for value in formatMatchValues {
            return isValidValueInArray(value)
        }
        return false
    }

}

