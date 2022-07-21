//
//  File.swift
//
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

struct HighScoreResponse: Decodable {

    let category: Int
    let type: Int
    let timestamp: String
    let serverId: String
    let highScores: [OGameAPI.HighScore]

    private enum CodingKeys: String, CodingKey {
        case category
        case type
        case timestamp
        case serverId
        case highScores = "player"
    }
}
