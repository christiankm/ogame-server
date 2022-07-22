//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 22/7/2022.
//

import Foundation

extension OGameLobby {
    
    public struct Account: Decodable {
        let id: Int
        let email: String
        let gameforgeAccountId: String
        let mhash: String
        let migrationRequired: Bool
        let portable: Bool
        let unlinkedAccounts: Bool
        let unportableName: String
        let userId: Int
        let validated: Bool
    }
}
