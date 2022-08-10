//
//  OGameServer
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

protocol Response: Decodable {
    associatedtype ResponseResult

    var status: String { get }
    var code: Int { get }
    var message: String { get }
    var result: ResponseResult { get }
}
