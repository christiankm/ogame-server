//
//  OGameService.swift
//  Interceptor
//
//  Created by Christian Mitteldorf on 29/04/2021.
//

import Combine
import Foundation
import XMLCoder

/// Official OGame API.
///
/// This contains methods to fetch various information about a given game server,
/// like high score, players, server data, etc.
public struct OGameAPI {

    let serverNumber: Int
    let serverCountry: String
    let serverLanguage: String

    private let session: URLSession
    private let decoder = XMLDecoder()

    private var cancellable: AnyCancellable?

    public init(
        serverNumber: Int,
        serverCountry: String,
        serverLanguage: String,
        requestTimeout: TimeInterval = 10
    ) {
        self.serverNumber = serverNumber
        self.serverCountry = serverCountry
        self.serverLanguage = serverLanguage

        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = requestTimeout
        self.session = URLSession(configuration: sessionConfiguration)
    }

    /// Fetch a list of all universes in a community (country).
    public func universes() async throws -> [OGameAPI.Universe] {
        let url = makeURL(endpoint: "universes")
        let (data, _) = try await session.data(from: url)
        let response = try decoder.decode(UniversesResponse.self, from: data)

        return response.universes
    }

    /// Fetch all server configuration data.
    public func serverData() async throws -> OGameAPI.ServerData {
        let url = makeURL(endpoint: "serverData")
        let (data, _) = try await session.data(from: url)
        let serverData = try decoder.decode(ServerData.self, from: data)

        return serverData
    }

    /// Fetch all players in the universe, including their id, username, status and alliance.
    public func players() async throws -> [OGameAPI.Player] {
        let url = makeURL(endpoint: "players")
        let (data, _) = try await session.data(from: url)
        let response = try decoder.decode(PlayersResponse.self, from: data)

        return response.players
    }

    /// Fetch list of all planets on the server along with their names, coordinates and owners.
    public func universe() async throws -> [OGameAPI.Planet] {
        let url = makeURL(endpoint: "universe")
        let (data, _) = try await session.data(from: url)
        let response = try decoder.decode(UniverseResponse.self, from: data)

        return response.planets
    }
    private func makeURL(endpoint: String) -> URL {
        let country: String
        switch serverLanguage.lowercased() {
        case "en":
            country = "en"
        case "da":
            country = "dk"
        default:
            fatalError("Unsupported language")
        }

        return URL(string: "https://s\(serverNumber)-\(country).ogame.gameforge.com/api/\(endpoint).xml")!
    }

    private func call<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()

        return publisher
    }
}
