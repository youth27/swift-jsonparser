//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation


struct GrammarChecker {
    
    let arrayPattern = "true|false|\".+?\"|\\d+|\\{.+?\\}|:"
    let objectPattern = "(\".+?\")\\:(true|false|\\\".+?\\\"|\\d+|\\[.+?\\])"

    enum FormatError: Error {
        case invalidArray
        case invalidObject
        
        var description: String {
            switch self {
            case .invalidArray:
                return "지원하지 않는 배열 형식입니다."
            case .invalidObject:
                return "지원하지 않는 객체 형식입니다."
            }
        }
    }
    
    private func checkArrayFormat (_ input: String) -> [String] { 
        do {
            let regex = try NSRegularExpression(pattern: arrayPattern)
            let nsInput = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: nsInput.length))
            let matchValues = matches.map{nsInput.substring(with: $0.range)}
            return matchValues
        } catch {
            print("지원하지 않는 형식입니다.")
            return []
        }
    }
    
    func checkArray (_ input: String) throws -> [String] {
        let formatMatchValues = checkArrayFormat(input)
        for value in formatMatchValues {
            if (value == ":")||(value == ",") {
                throw GrammarChecker.FormatError.invalidArray
            }
            if (value.hasPrefix("{") && value.hasSuffix("}")) {
                if !value.contains(":") {
                    throw GrammarChecker.FormatError.invalidArray
                }
            }
        }
        return formatMatchValues
    }

    private func checkObjectFormat (_ input: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: objectPattern)
            let nsInput = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: nsInput.length))
            let matchValues = matches.map{nsInput.substring(with: $0.range)}
            return matchValues
        } catch {
            print("지원하지 않는 형식입니다.")
            return []
        }
    }

    func checkObject (_ input: String) throws -> [String] {
        let formatMatchValues = checkObjectFormat(input)
        for value in formatMatchValues {
            if !value.contains(":") {
                throw GrammarChecker.FormatError.invalidObject
            }
        }
        return formatMatchValues
    }


}
