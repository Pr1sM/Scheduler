//
//  logger.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/24/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public enum LoggerLevel:Int {
    case trace = 0
    case debug = 1
    case normal = 2
    case warning = 3
    case error = 4
    case fatal = 5
    
    func toString() -> String {
        switch self {
        case .trace:
            return "[TRACE]"
        case .debug:
            return "[DEBUG]"
        case .normal:
            return "[NORML]"
        case .warning:
            return "[WARNG]"
        case .error:
            return "[ERROR]"
        case .fatal:
            return "[FATAL]"
        }
    }
}

public class Logger {
    
    public static let shared = Logger()
    
    public var level:LoggerLevel
    
    public init() {
        self.level = .normal
    }

    public init(withLevel level:LoggerLevel) {
        self.level = level
    }
    
    public func t(_ msg:String) {
        log(message: msg, atLevel: .trace)
    }
    
    public func d(_ msg:String) {
        log(message: msg, atLevel: .debug)
    }
    
    public func n(_ msg:String) {
        log(message: msg, atLevel: .normal)
    }
    
    public func w(_ msg:String) {
        log(message: msg, atLevel: .warning)
    }
    
    public func e(_ msg:String) {
        log(message: msg, atLevel: .error)
    }
    
    public func f(_ msg:String) {
        log(message: msg, atLevel: .fatal)
    }
    
    private func log(message msg:String, atLevel level:LoggerLevel) {
        // Check if message level is too low to display
        if(level.rawValue < self.level.rawValue) {
            return
        }
        
        print("\(level.toString()): \(msg)")
    }
}
