//
//  File.swift
//  
//
//  Created by ServAir on 7/7/2022.
//

import Foundation
import OGame

extension OGameAPI {

    public struct Planet: Identifiable, Nameable {
        public let id: Identifier
        public let name: String
        public let playerId: PlayerId
        public let coordinates: OGameAPI.Coordinate
        public let moon: Moon?
    }
}

extension OGameAPI.Planet: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case playerId = "player"
        case coordinates = "coords"
        case moon
    }
}
