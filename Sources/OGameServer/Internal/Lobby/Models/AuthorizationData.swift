//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 22/7/2022.
//

import Foundation

extension OGameLobby {
    
    struct AuthorizationData: Decodable {
        let hasUnmigratedGameAccounts: Bool
        let isGameAccountCreated: Bool
        let isGameAccountMigrated: Bool
        let isPlatformLogin: Bool
        let platformUserId: String // UUID
        let token: String // UUID
    }
}
