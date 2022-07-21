//
//  OGameAPITests.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

import OGameServer
import XCTest

final class OGameAPITests: XCTestCase {

    private var session: MockURLSession!
    private var sut: OGameAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        sut = OGameAPI(
            serverNumber: 801,
            serverCountry: "en",
            serverLanguage: "en",
            session: session
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        session = nil
        try super.tearDownWithError()
    }

    func testUniverses() async throws {
        try session.stubWithResource("universes", ofType: "xml")

        let universes = try await sut.universes()
        let bermuda = try XCTUnwrap(universes.first { $0.id == "801" })

        XCTAssertEqual(bermuda.id, "801")
        XCTAssertEqual(bermuda.url, "https://s801-en.ogame.gameforge.com")
    }

    func testServerData() async throws {
        try session.stubWithResource("server_data", ofType: "xml")

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

    func testPlayers() async throws {
        try session.stubWithResource("players", ofType: "xml")

        let players = try await sut.players()
        let playerInterceptor = try XCTUnwrap(players.first { $0.id == 130196 })
        let inactivePlayer = try XCTUnwrap(players.first { $0.id == 130241 })

        XCTAssertEqual(players.count, 4742)
        XCTAssertEqual(playerInterceptor.name, "Interceptor")
        XCTAssertEqual(playerInterceptor.allianceId, 501227)
        XCTAssertEqual(inactivePlayer.status, .inactive)
    }

    func testUniverse() async throws {
        try session.stubWithResource("universe", ofType: "xml")

        let planets = try await sut.universe()
        let planet = try XCTUnwrap(planets.first { $0.id == 33622654 })

        XCTAssertEqual(planets.count, 18016)
        XCTAssertEqual(planet.id, 33622654)
        XCTAssertEqual(planet.name, "GEMINI")
        XCTAssertEqual(planet.playerId, 100426)
        XCTAssertEqual(planet.coordinates.galaxy, 1)
        XCTAssertEqual(planet.coordinates.system, 153)
        XCTAssertEqual(planet.coordinates.position, 8)

        let moon = try XCTUnwrap(planet.moon)
        XCTAssertEqual(moon.id, 33633668)
        XCTAssertEqual(moon.name, "Moon")
        XCTAssertEqual(moon.size, 7485)
    }

    func testAlliances() async throws {
        try session.stubWithResource("alliances", ofType: "xml")

        let alliances = try await sut.alliances()
        let btmi = try XCTUnwrap(alliances.first { $0.id == 501227 })

        XCTAssertEqual(btmi.id, 501227)
        XCTAssertEqual(btmi.tag, "btmi")
        XCTAssertEqual(btmi.name, "Big Time Mining Inc")
        XCTAssertEqual(btmi.founder, 128574)
        XCTAssertEqual(btmi.foundedDate, "1651007015")
        XCTAssertEqual(btmi.members.count, 6)
        XCTAssertNil(btmi.logoURL)
        XCTAssertTrue(btmi.isOpen)
    }

    func testHighScore() async throws {
        try session.stubWithResource("highscore", ofType: "xml")

        let highScore = try await sut.highScore(category: .player, type: .total)
        let player = try XCTUnwrap(highScore.first { $0.playerId == 131615 })

        XCTAssertEqual(highScore.count, 4692)
        XCTAssertEqual(player.playerId, 131615)
        XCTAssertEqual(player.position, 127)
        XCTAssertEqual(player.score, 791_870_117)
    }
}
