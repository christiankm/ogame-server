//
//  Player.swift
//  Interceptor
//
//  Created by Christian Mitteldorf on 29/04/2021.
//

import Foundation
import OGame
import XMLCoder

extension OGameAPI {

    public struct Player: Decodable {

        public enum Status: String, Decodable {
            case admin = "a"
            case active
            case inactive = "i"
            case inactiveLong = "I"
            case vacation = "v"
            case vacationLong = "V"
            case vacationInactive = "vi"
            case vacationInactiveLong = "vI"
            case vacationBanned = "vb"
            case vacationInactiveBanned = "vib"
            case vacationInactiveLongBanned = "vIb"
        }

        public let id: PlayerId
        public let name: String

        /// The users current status. If this value is nil, the user is most likely normal active.
        public let status: Status
        public let allianceId: GameId?

        public var isActive: Bool {
            status == .active
        }

        public var isInactive: Bool {
            status == .inactive ||
            status == .inactiveLong
        }

        public var isInVacationMode: Bool {
            status == .vacation ||
            status == .vacationLong ||
            status == .vacationInactive ||
            status == .vacationInactiveLong
        }

        public var isBanned: Bool {
            status == .vacationBanned ||
            status == .vacationInactiveBanned ||
            status == .vacationInactiveLongBanned
        }

        private enum CodingKeys: CodingKey {
            case id
            case name
            case status
            case alliance
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Player.CodingKeys.self)
            self.id = Int(try container.decode(String.self, forKey: .id))!
            self.name = try container.decode(String.self, forKey: .name)
            if let status = try container.decodeIfPresent(Status.self, forKey: .status) {
                self.status = status
            } else {
                self.status = .active
            }
            if let allianceId = try container.decodeIfPresent(String.self, forKey: .alliance) {
                self.allianceId = Int(allianceId)!
            } else {
                self.allianceId = nil
            }
        }
    }

    struct PlayersResponse: Decodable {
        let players: [OGameAPI.Player]

        private enum CodingKeys: String, CodingKey {
            case players = "player"
        }
    }
}
