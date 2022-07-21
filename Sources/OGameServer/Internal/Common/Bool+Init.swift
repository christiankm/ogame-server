//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import Foundation

extension Bool {

    init?(_ string: String) {
        if string == "1" {
            self = true
        } else if string == "0" {
            self = false
        } else {
            return nil
        }
    }

    init?(_ int: Int) {
        if int == 1 {
            self = true
        } else if int == 0 {
            self = false
        } else {
            return nil
        }
    }
}
