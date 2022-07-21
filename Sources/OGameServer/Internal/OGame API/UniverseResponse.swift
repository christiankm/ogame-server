//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

struct UniverseResponse: Decodable {
    let planets: [OGameAPI.Planet]

    private enum CodingKeys: String, CodingKey {
        case planets = "planet"
    }
}
