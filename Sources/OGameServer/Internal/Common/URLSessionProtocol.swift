//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from: URL) async throws -> (Data, URLResponse)
    func data(for: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
