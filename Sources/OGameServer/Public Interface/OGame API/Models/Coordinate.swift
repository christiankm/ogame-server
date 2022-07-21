//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import Foundation
import OGame

extension OGameAPI {

    public struct Coordinate {
        public let galaxy: Galaxy
        public let system: System
        public let position: Position
    }
}

extension OGameAPI.Coordinate: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let coordinates = try container.decode(String.self)
        let components = coordinates.split(separator: ":")

        assert(components.count == 3)

        self.init(
            galaxy: Int(components[0])!,
            system: Int(components[1])!,
            position: Int(components[2])!
        )
    }
}
