//
//  OGameAPITests.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import OGameServer
import XCTest

final class OGameAPITests: XCTestCase {

    private let sut = OGameAPI(
        serverNumber: 801,
        serverCountry: "en",
        serverLanguage: "en"
    )

    func testServerData() async throws {
        let serverData = try await sut.serverData()

        XCTAssertEqual(serverData.name, "Bermuda")
        XCTAssertEqual(serverData.number, 801)
        XCTAssertEqual(serverData.language, "en")
        XCTAssertEqual(serverData.timezone, "Europe/London")
        XCTAssertEqual(serverData.timezoneOffset, "+01:00")
        XCTAssertEqual(serverData.domain, "s801-en.ogame.gameforge.com")
        XCTAssertEqual(serverData.version, "9.0.1")
        XCTAssertEqual(serverData.speed, 4)
        XCTAssertEqual(serverData.galaxies, 9)
        XCTAssertEqual(serverData.systems, 499)
        XCTAssertEqual(serverData.acs, true)
        XCTAssertEqual(serverData.rapidFire, true)
        XCTAssertEqual(serverData.defToTF, true)
        XCTAssertEqual(serverData.debrisFactor, 0.7)
        XCTAssertEqual(serverData.debrisFactorDef, 0.5)
        XCTAssertEqual(serverData.repairFactor, 0.7)
        XCTAssertEqual(serverData.newbieProtectionLimit, 500000)
        XCTAssertEqual(serverData.newbieProtectionHigh, 50000)
        XCTAssertEqual(serverData.bonusFields, 0)
    }
}
