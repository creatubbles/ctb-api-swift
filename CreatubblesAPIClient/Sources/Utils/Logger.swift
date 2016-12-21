//
//  Logger.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import XCGLogger

public enum LogLevel
{
    case verbose
    case debug
    case info
    case warning
    case error
    case severe
    case none
}

public protocol LogListener: class
{
    func log(logLevel: LogLevel, message: String?, fileName: String, lineNumber: Int, date: Date)
}

class Logger
{
    private static var loggerIdentifier = "com.creatubbles.CreatubblesAPIClient.logger"
    private static var logger = XCGLogger(identifier: loggerIdentifier, includeDefaultDestinations: true)
    private static var listeners: Array<LogListener> = Array<LogListener>()
    
    class func log(_ level: LogLevel, _ message:String?, fileName: StaticString = #file, lineNumber: Int = #line)
    {
        listeners.forEach({ $0.log(logLevel: level, message: message, fileName: String(describing: fileName), lineNumber: lineNumber, date: Date()) })

        switch level
        {
            case .verbose:  logger.verbose(message, fileName: fileName, lineNumber: lineNumber)
            case .debug:    logger.debug(message, fileName: fileName, lineNumber: lineNumber)
            case .info:     logger.info(message, fileName: fileName, lineNumber: lineNumber)
            case .warning:  logger.warning(message, fileName: fileName, lineNumber: lineNumber)
            case .error:    logger.error(message, fileName: fileName, lineNumber: lineNumber)
            case .severe:   logger.severe(message, fileName: fileName, lineNumber: lineNumber)
            case .none:     return
        }
    }
    
    class func setup(logLevel: LogLevel = .info)
    {
        logger.setup(level: Logger.logLevelToXCGLevel(level: logLevel), showLogIdentifier: true, showFunctionName: false, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: nil)
    }
    
    private class func logLevelToXCGLevel(level: LogLevel) -> XCGLogger.Level
    {
        switch level
        {
            case .verbose:  return .verbose
            case .debug:    return .debug
            case .info:     return .info
            case .warning:  return .warning
            case .error:    return .error
            case .severe:   return .severe
            case .none:     return .none
        }
    }
    
    class func addListener(listener: LogListener)
    {
        if !listeners.contains(where: { $0 === listener})
        {
            listeners.append(listener)
        }
        
    }
}
