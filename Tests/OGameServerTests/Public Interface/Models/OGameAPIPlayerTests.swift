//
//  OGameAPIPlayerTests.swift
//  
//
//  Created by Christian Mitteldorf on 19/7/2022.
//

@testable import OGameServer
import XCTest
import XMLCoder

final class OGameAPIPlayerTests: XCTestCase {

    private static func playerData() throws -> [OGameAPI.Player] {
        let playerData = try XMLDecoder().decode(file: "players") as OGameAPI.PlayersResponse
        return playerData.players
    }

    func testPlayer() throws {
        let player = try XCTUnwrap(Self.playerData().first)
        XCTAssertEqual(player.id, 1)
        XCTAssertEqual(player.name, "Legor")
    }

    func testPlayerInAlliance() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130173 })
        XCTAssertEqual(player.id, 130173)
        XCTAssertEqual(player.name, "Lieutenant Owl")
        XCTAssertEqual(player.allianceId, 501523)
    }

    func testPlayerStatusActive() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130196 })
        XCTAssertEqual(player.id, 130196)
        XCTAssertEqual(player.name, "Interceptor")
        XCTAssertEqual(player.status, .active)
        XCTAssertTrue(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusInactive() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130191 })
        XCTAssertEqual(player.id, 130191)
        XCTAssertEqual(player.name, "Constable Ceres")
        XCTAssertEqual(player.status, .inactive)
        XCTAssertFalse(player.isActive)
        XCTAssertTrue(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusInactiveLong() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130186 })
        XCTAssertEqual(player.id, 130186)
        XCTAssertEqual(player.name, "Bandit Probe")
        XCTAssertEqual(player.status, .inactiveLong)
        XCTAssertFalse(player.isActive)
        XCTAssertTrue(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusVacation() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130518 })
        XCTAssertEqual(player.id, 130518)
        XCTAssertEqual(player.name, "Governor Gemini")
        XCTAssertEqual(player.status, .vacation)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertTrue(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusVacationInactive() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130584 })
        XCTAssertEqual(player.id, 130584)
        XCTAssertEqual(player.name, "TECTEP")
        XCTAssertEqual(player.status, .vacationInactive)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertTrue(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusVacationInactiveLong() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130323 })
        XCTAssertEqual(player.id, 130323)
        XCTAssertEqual(player.name, "Koma")
        XCTAssertEqual(player.status, .vacationInactiveLong)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertTrue(player.isInVacationMode)
        XCTAssertFalse(player.isBanned)
    }

    func testPlayerStatusVacationBanned() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 133067 })
        XCTAssertEqual(player.id, 133067)
        XCTAssertEqual(player.name, "Amiral Furrybird")
        XCTAssertEqual(player.status, .vacationBanned)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertTrue(player.isBanned)
    }

    func testPlayerStatusVacationInactiveBanned() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 128709 })
        XCTAssertEqual(player.id, 128709)
        XCTAssertEqual(player.name, "MALKOCOGLU")
        XCTAssertEqual(player.status, .vacationInactiveBanned)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertTrue(player.isBanned)
    }

    func testPlayerStatusVacationInactiveLongBanned() throws {
        let player = try XCTUnwrap(Self.playerData().first { $0.id == 130042 })
        XCTAssertEqual(player.id, 130042)
        XCTAssertEqual(player.name, "Oui et Alors")
        XCTAssertEqual(player.status, .vacationInactiveLongBanned)
        XCTAssertFalse(player.isActive)
        XCTAssertFalse(player.isInactive)
        XCTAssertFalse(player.isInVacationMode)
        XCTAssertTrue(player.isBanned)
    }
}
