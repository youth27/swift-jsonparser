//
//  InputView.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readCommandLine() -> (I: String, O: String) {
        let arguments = CommandLine.arguments
        var cmdInput = ""
        var cmdOutput = "default.json"
        
        if arguments.count < 2 {
            cmdInput = askUserInput()
            return (I:cmdInput,O:"")
        }
        if arguments.count == 2 {
            cmdInput = readFile(String(arguments[1]))
            return (I:cmdInput, O:cmdOutput)
        }
        
        if arguments.count > 2 {
            cmdInput = readFile(String(arguments[1]))
            cmdOutput = arguments[2]
            return (I:cmdInput, O:cmdOutput)
        }
        
        return (I:cmdInput, O:cmdOutput)
    }
    
    
    func readFile(_ file: String) -> String {
        var text = ""
        
        let inputFile = file.split(separator: ".")
        let inputFileName = String(inputFile[0])
        let inputFileType = String(inputFile[1])
        let path = Bundle.main.path(forResource: inputFileName, ofType: inputFileType)
        text = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
        
        return text
    }
    
    func askUserInput () -> String {
        print("분석할 JSON 데이터를 입력하세요.")
        let userInput = readLine()
        let input = userInput ?? ""
        if input == "" {
            return askUserInput()
        }
        return input
    }
}

