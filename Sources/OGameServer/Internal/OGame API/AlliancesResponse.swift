//
//  File.swift
//
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

struct AlliancesResponse: Decodable {

    let timestamp: String
    let serverId: String
    let alliances: [OGameAPI.Alliance]

    private enum CodingKeys: String, CodingKey {
        case timestamp
        case serverId
        case alliances = "alliance"
    }
}
