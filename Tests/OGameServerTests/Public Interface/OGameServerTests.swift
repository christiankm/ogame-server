//
//  OGameServer
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import OGameServer
import XCTest

final class OGameServerTests: XCTestCase {

    private var session: MockURLSession!
    private var sut: OGameServer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        sut = OGameServer(
            ogamedHost: URL(string: "127.0.0.1:9000")!,
            lobby: .pioneers,
            serverNumber: 801,
            serverCountry: "en",
            serverLanguage: "en"
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        session = nil
        try super.tearDownWithError()
    }

    func testConnect() async throws {
        let accounts = try await sut.connect(email: "abc@def.dk", password: "TrustNo1")

        XCTAssertEqual(accounts.count, 1)
    }
}
