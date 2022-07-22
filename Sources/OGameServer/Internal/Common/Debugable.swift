//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

protocol Debugable {
    func print()
}

extension Debugable {
    func print() {
        Swift.print(self)
    }
}

extension Data: Debugable {

    func print() {
        Swift.print(String(decoding: self, as: UTF8.self))
    }
}

extension URLResponse: Debugable {}
extension HTTPURLResponse: Debugable {}
