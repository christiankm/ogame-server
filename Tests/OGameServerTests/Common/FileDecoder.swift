//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import Foundation
import XMLCoder

extension JSONDecoder {

    func decode<T: Decodable>(file: String) throws -> T {
        let data = try TestBundle.data(forResource: file, ofType: "json")
        return try decode(T.self, from: data)
    }
}

extension XMLDecoder {

    func decode<T: Decodable>(file: String) throws -> T {
        let data = try TestBundle.data(forResource: file, ofType: "xml")
        return try decode(T.self, from: data)
    }
}

private class TestBundle: Bundle {

    static func data(forResource resource: String, ofType type: String) throws -> Data {
        guard let path = Bundle.module.path(forResource: resource, ofType: type) else {
            preconditionFailure("\(resource).\(type) not found")
        }

        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}
