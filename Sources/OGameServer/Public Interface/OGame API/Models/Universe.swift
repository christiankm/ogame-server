import Foundation

extension OGameAPI {

    public typealias UniverseId = String

    public struct Universe {
        public let id: UniverseId
        public let url: String
    }
}

extension OGameAPI.Universe: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case url = "href"
    }
}
