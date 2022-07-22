//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 22/7/2022.
//

import Foundation

extension OGameLobby {
    
    public struct Account: Decodable {
        let email: String
        let gameforgeAccountId: String
        let id: Int
        let mhash: Data
        let migrationRequired: Bool
        let portable: Bool
        let unlinkedAccounts: Bool
        let unportableName: String
        let userId: Int
        let validated: Bool
    }
}
