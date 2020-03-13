//
// Logger.swift
//
// Created by DevYeom on 06/21/2019
//

import Foundation

private enum LogType {
    case info
    case debug
    case error

    var symbol: String {
        switch self {
        case .info: return "✅"
        case .debug: return "🐛"
        case .error: return "💥"
        }
    }
}

func InfoLog<T>(_ closure: @autoclosure () -> T, _ file: String = #file, _ line: Int = #line) {
    #if DEBUG
    Log(closure, .info, file, line)
    #endif
}

func DebugLog<T>(_ closure: @autoclosure () -> T, _ file: String = #file, _ line: Int = #line) {
    #if DEBUG
    Log(closure, .debug, file, line)
    #endif
}

func ErrorLog<T>(_ closure: @autoclosure () -> T, _ file: String = #file, _ line: Int = #line) {
    #if DEBUG
    Log(closure, .error, file, line)
    #endif
}

private func Log<T>(_ closure: () -> T, _ type: LogType, _ file: String, _ line: Int) {
    #if DEBUG
    let instance = closure()
    let description: String

    if let debugString = instance as? CustomDebugStringConvertible {
        description = debugString.debugDescription
    } else {
        description = "\(instance)"
    }

    let file = URL(fileURLWithPath: file).lastPathComponent
    let queue = Thread.isMainThread ? "MainThread🚗" : "OtherThread🚙"

    print("<\(queue)> \(file) [\(line)]: \(type.symbol) \(description)")
    #endif
}
