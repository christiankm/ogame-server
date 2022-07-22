//
//  Account.swift
//  ogamebot
//
//  Created by Christian Mitteldorf on 06/12/2020.
//

import Foundation
import OGame

public struct GameAccount: Decodable, Nameable, Identifiable {

    public struct Sitting: Decodable {
        public let cooldownTime: String?
        public let endTime: String?
        public let shared: Bool
    }

    public struct Trading: Decodable {
        public let cooldownTime: String?
        public let trading: Bool
    }

    public struct Detail: Decodable {
        public let type: String
        public let title: String
        public let value: String
    }

    public let gameAccountId: Int
    public let id: Identifier
    public let name: String
    public let accountGroup: String
    public let server: GameServer
    public let bannedReason: String?
    public let bannedUntil: String?
    public let blocked: Bool
    public let details: [Detail]
    public let lastLogin: String
    public let lastPlayed: String
    public let sitting: Sitting
    public let trading: Trading
}
