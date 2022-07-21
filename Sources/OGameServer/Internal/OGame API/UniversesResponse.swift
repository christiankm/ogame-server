//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

struct UniversesResponse: Decodable {

    let timestamp: String
    let serverId: String
    let universes: [OGameAPI.Universe]

    private enum CodingKeys: String, CodingKey {
        case timestamp
        case serverId
        case universes = "universe"
    }
}
