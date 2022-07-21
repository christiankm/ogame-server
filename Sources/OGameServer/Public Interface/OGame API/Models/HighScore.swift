//
//  File.swift
//  
//
//  Created by ServAir on 7/7/2022.
//

import Foundation

extension OGameAPI {

    public enum HighScoreCategory: Int {
        case player = 1
        case alliance = 2
    }

    public enum HighScoreType: Int {
        case total = 0
        case economy = 1
        case research = 2
        case military = 3
        case militaryLost = 4
        case militaryBuilt = 5
        case militaryDestroyed = 6
        case honor = 7
    }

    public struct HighScore {
        public let playerId: PlayerId
        public let position: Int
        public let score: Int
    }
}

extension OGameAPI.HighScore: Decodable {

    private enum CodingsKeys: String, CodingKey {
        case playerId = "id"
        case position
        case score
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingsKeys.self)
        let playerId = try container.decode(PlayerId.self, forKey: .playerId)
        let position = try container.decode(Int.self, forKey: .position)
        let score = try container.decode(PlayerId.self, forKey: .score)

        self.playerId = playerId
        self.position = position
        self.score = score
    }
}
