//
//  Logger.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

public func DebugLog(_ message: Any, file: String = #file, function: String = #function, line: UInt = #line) {
    #if DEBUG
        let fileName = file.split(separator: "/").last ?? ""
        let funcName = function.split(separator: "(").first ?? ""
        print("😱 [\(fileName)] \(funcName) (\(line)): \(message)")
    #endif
}
