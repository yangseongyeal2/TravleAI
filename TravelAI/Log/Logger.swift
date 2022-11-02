//
//  Logger.swift
//  TravelAI
//
//  Created by mobile_ on 2022/10/30.
//

import Foundation

struct Logger {
    public func Log_Y(_ object: Any, filename: String = #file, _ line: Int = #line, _ funcname: String = #function) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss:SSS"
//        print("Log!! : \(dateFormatter.string(from: Date())) file: \(filename) line: \(line) func: \(funcname)")
//        print(object)
        
        print("[\(Date())] [\(filename.components(separatedBy: "/").last ?? "")] [\(funcname)] [\(line)]: \n \(object) ")
    }

}

