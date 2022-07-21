//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import Foundation
import OGameServer

final class MockURLSession: URLSessionProtocol {

    private(set) var lastURL: URL?
    var nextData: Data?

    func stubWithResource(_ resource: String, ofType type: String) throws {
        nextData = try TestBundle.data(forResource: resource, ofType: type)
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        lastURL = url

        if let data = nextData {
            nextData = nil
            return (data, HTTPURLResponse())
        } else {
            print("💥 WARNING: Test data for URL '\(lastURL!)' not mocked. Fetching real data...")
            return try await URLSession.shared.data(from: url)
        }
    }

    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        lastURL = urlRequest.url!

        if let data = nextData {
            nextData = nil
            return (data, HTTPURLResponse())
        } else {
            print("💥 WARNING: Test data for URL '\(lastURL!)' not mocked. Fetching real data...")
            return try await URLSession.shared.data(for: urlRequest)
        }
    }
}
