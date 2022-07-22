//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 22/7/2022.
//

import Foundation

extension OGameLobby {

    struct LoginData: Encodable {
        let autoGameAccountCreation: Bool
        let gameEnvironmentId: String // UUID
        let gfLang: String
        let identity: String
        let locale: String
        let password: String
        let platformGameId: String // UUID
    }
}
