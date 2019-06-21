//
// Logger.swift
//
// Created by DevYeom on 06/21/2019
//

import Foundation

func logger<T>(_ closure: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
	#if DEBUG
		let instance = closure()
		let description: String

		if let debugString = instance as? CustomDebugStringConvertible {
			description = debugString.debugDescription
		} else {
			description = "\(instance)"
		}

		let file = URL(fileURLWithPath: file).lastPathComponent
		let queue = Thread.isMainThread ? "MainThread" : "OtherThread"

		print("<\(queue)> \(file) -> \(function) [\(line)]: \(description)")
	#endif
}
