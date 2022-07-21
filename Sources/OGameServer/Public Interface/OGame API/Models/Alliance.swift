//
//  File.swift
//  
//
//  Created by ServAir on 7/7/2022.
//

import Foundation

extension OGameAPI {

    public typealias AllianceId = Int

    public struct Alliance: Identifiable {
        public let id: AllianceId
        public let tag: String
        public let name: String
        public let founder: PlayerId
        public let foundedDate: String
        public let members: [Member]
        public let logoURL: String?
        public let isOpen: Bool

        public struct Member: Decodable {
            public let id: PlayerId
        }
    }
}

extension OGameAPI.Alliance: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case tag
        case name
        case founder
        case foundedDate = "foundDate"
        case members = "player"
        case logoURL = "logo"
        case isOpen = "open"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(OGameAPI.AllianceId.self, forKey: .id)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.name = try container.decode(String.self, forKey: .name)
        self.founder = try container.decode(PlayerId.self, forKey: .founder)
        self.foundedDate = try container.decode(String.self, forKey: .foundedDate)
        self.members = try container.decode([Member].self, forKey: .members)
        self.logoURL = try container.decodeIfPresent(String.self, forKey: .logoURL)

        if let open = try container.decodeIfPresent(String.self, forKey: .isOpen) {
            guard let isOpen = Bool(open) else { preconditionFailure() }
            self.isOpen = isOpen
        } else {
            self.isOpen = false
        }
    }
}
