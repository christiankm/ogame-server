//
//  File.swift
//  
//
//  Created by ServAir on 10/8/2022.
//

import Foundation

struct LogoutResponse: Response {
    var status: String
    var code: Int
    var message: String
    var result: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "Message"
        case result = "Result"
    }
}
