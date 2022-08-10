//
//  OGameServer
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation
import OGame

@available(*, deprecated)
struct OgamedClient {

    enum OgamedError: Error {
        case couldNotConnect
        case loginFailed
        case logoutFailed
        case invalidData
    }

    private enum Endpoint: String {
        case login = "/login"
        case logout = "/logout"
        case serverVersion = "/server/version"
        case serverTime = "/server/time"
        case userInfo = "/user-infos"
        case isUnderAttack = "/is-under-attack"
        case fleets = "/fleets"
        case fleetSlots = "/fleets/slots"
        case planets = "/planets"
        case planetResources = "/planetResources"
    }

    private let baseURL: URL
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()

    init(baseURL: URL, session: URLSessionProtocol = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }

    // MARK: Lobby and Login

    func logout() async throws {
        let request = makeRequest(for: .logout)
        let (data, _) = try await session.data(for: request)
        let decoded = try decoder.decode(LogoutResponse.self, from: data)

        guard decoded.status == "ok" else { throw OgamedError.logoutFailed }
    }

    // MARK: Request builders

    private func makeRequest(for endpoint: Endpoint) -> URLRequest {
        URLRequest(url: URL(string: "\(baseURL.absoluteString)/bot\(endpoint.rawValue)")!)
    }

    private func makeRequest(withString endpointString: String) -> URLRequest {
        URLRequest(url: URL(string: "\(baseURL.absoluteString)/bot\(endpointString)")!)
    }
}
