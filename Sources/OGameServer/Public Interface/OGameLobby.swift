//
//  File.swift
//  
//
//  Created by ServAir on 18/7/2022.
//

import Foundation
import OGame

public enum LobbyError: Error {
    case loginFailed
    case unauthorized
    case unknown
}

public final class OGameLobby {

    public enum GameLobby {
        case live
        case pioneers

        var baseURL: URL {
            switch self {
            case .live:
                return URL(string: "https://lobby.ogame.gameforge.com/api")!
            case .pioneers:
                return URL(string: "https://lobby-pioneers.ogame.gameforge.com/api")!
            }
        }
    }

    private let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) " +
                            "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 " +
                            "Safari/605.1.15"

    private let session: URLSessionProtocol

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let lobby: GameLobby
    private var authorization: String?

    public init(lobby: GameLobby = .live, session: URLSessionProtocol = URLSession.shared) {
        self.lobby = lobby
        self.session = session
    }

    public func login(email: String, password: String) async throws -> [GameAccount] {
        let loginData = OGameLobby.LoginData(
            autoGameAccountCreation: false,
            gameEnvironmentId: "0a31d605-ffaf-43e7-aa02-d06df7116fc8",
            gfLang: "en",
            identity: email,
            locale: "en_EN",
            password: password,
            platformGameId: "1dfd8e7e-6e1a-4eb1-8c64-03c3b62efd2f"
        )

        // Open session to lobby and login
        var request = URLRequest(url: URL(string: "https://gameforge.com/api/v1/auth/thin/sessions")!)
        request.httpMethod = "POST"
        request.httpBody = try encoder.encode(loginData)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else { throw LobbyError.unknown }

        // Solve Captcha challenge if required
        if httpResponse.statusCode == 409 {
            let challengeId = httpResponse.value(forHTTPHeaderField: "gf-challenge-id")!.split(separator: ";").first!
            try await CaptchaSolver().solve(challengeId: String(challengeId), userAgent: userAgent)

            return try await login(email: email, password: password)
        }

        guard httpResponse.statusCode == 201 else {
            throw LobbyError.loginFailed
        }

        let authorizedData = try decoder.decode(AuthorizationData.self, from: data)

        let authorization = "Bearer \(authorizedData.token)"
        self.authorization = authorization

        let _ = try await account()
        let gameAccounts = try await gameAccounts()

        return gameAccounts
    }

    public func account() async throws -> Account {
        guard let authorization = self.authorization else { throw LobbyError.unauthorized }

        var accountRequest = URLRequest(url: URL(string: "\(lobby.baseURL)/users/me")!)
        accountRequest.setValue(authorization, forHTTPHeaderField: "Authorization")
        accountRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (accountData, _) = try await session.data(for: accountRequest)
        let account = try decoder.decode(Account.self, from: accountData)

        return account
    }

    public func gameAccounts() async throws -> [GameAccount] {
        guard let authorization = self.authorization else { throw LobbyError.unauthorized }

        var gameAccountsRequest = URLRequest(url: URL(string: "\(lobby.baseURL.absoluteString)/users/me/accounts")!)
        gameAccountsRequest.setValue(authorization, forHTTPHeaderField: "Authorization")
        gameAccountsRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (gameAccountsData, _) = try await session.data(for: gameAccountsRequest)
        let gameAccounts = try decoder.decode([GameAccount].self, from: gameAccountsData)

        return gameAccounts
    }
}
