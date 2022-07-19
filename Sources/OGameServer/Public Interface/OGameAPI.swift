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
public final class OGameAPI {

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

    /// Fetch all server configuration data.
    /// This data is updated once a day.
    public func serverData() async throws -> ServerData {
        let url = makeURL(endpoint: "serverData")!
        let (data, _) = try await session.data(from: url)
        let serverData = try decoder.decode(ServerData.self, from: data)

        return serverData
    }

    private func makeURL(endpoint: String) -> URL? {
        let country: String
        switch serverLanguage.lowercased() {
        case "en":
            country = "en"
        case "da":
            country = "dk"
        default:
            fatalError("Unsupported language")
        }

        return URL(string: "https://s\(serverNumber)-\(country).ogame.gameforge.com/api/\(endpoint).xml")
    }

    private func call<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: XMLDecoder())
            .eraseToAnyPublisher()

        return publisher
    }
}
