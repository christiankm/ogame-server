//
//  OGameServer
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import OGameServer
import XCTest

final class OGameLobbyTests: XCTestCase {

    private var session: MockURLSession!
    private var sut: OGameLobby!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        sut = OGameLobby(lobby: .pioneers, session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        session = nil
        try super.tearDownWithError()
    }

    func testLogin() async throws {
        let accounts = try await sut.login(email: "abc@def.dk", password: "TrustNo1")

        XCTAssertEqual(accounts.count, 1)
    }
}
