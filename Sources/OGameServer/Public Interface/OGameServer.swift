//
//  OGameServer
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

// The main interface to connecting to the game servers.
// It provides an interface to request and parse information from the OGame server as well as send commands to the game server.
public struct OGameServer {

    private let serverNumber: Int
    private let serverCountry: String
    private let serverLanguage: String
    private let ogameAPI: OGameAPI
    private let ogameLobby: OGameLobby
    private let ogamedClient: OgamedClient

    public init(
        ogamedHost: URL,
        lobby: OGameLobby.GameLobby,
        serverNumber: Int,
        serverCountry: String,
        serverLanguage: String
    ) {
        self.serverNumber = serverNumber
        self.serverCountry = serverCountry
        self.serverLanguage = serverLanguage
        self.ogameAPI = OGameAPI(
            serverNumber: serverNumber,
            serverCountry: serverCountry,
            serverLanguage: serverLanguage
        )
        self.ogameLobby = OGameLobby(lobby: lobby)
        self.ogamedClient = OgamedClient(baseURL: ogamedHost)
    }
    
    // MARK: - Connection

    /// Connect and login to game lobby.
    public func connect(email: String, password: String) async throws -> [GameAccount] {
        let lobbyLoginData = try await ogameLobby.login(email: email, password: password)

        return lobbyLoginData
    }
}
