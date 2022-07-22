//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 22/7/2022.
//

import Foundation

struct CaptchaChallengeStatus: Decodable {
    let id: String
    let lastUpdated: TimeInterval
    let status: String
}
