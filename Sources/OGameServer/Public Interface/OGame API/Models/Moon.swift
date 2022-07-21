//
//  Moon.swift
//  
//
//  Created by ServAir on 7/7/2022.
//

import Foundation

extension OGameAPI {
    
    public struct Moon: CelestialBody, Identifiable {
        public let id: Int
        public let name: String
        public let size: Int
    }
}

extension OGameAPI.Moon: Decodable {}
