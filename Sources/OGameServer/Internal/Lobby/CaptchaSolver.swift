//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 21/7/2022.
//

import CommonCrypto
import CoreImage
import Foundation

struct CaptchaSolver {

    enum CaptchaError: Error {
        case unresolved
        case unknown
    }

    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func solve(challengeId: String, userAgent: String) async throws {
        let challengeURL = URL(string: "https://image-drop-challenge.gameforge.com/challenge/\(challengeId)/en-GB")
        var request = URLRequest(url: challengeURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (data, _) = try await session.data(for: request)
        let captchaStatus = try decoder.decode(CaptchaChallengeStatus.self, from: data)

        guard captchaStatus.status == "presented" else {
            throw CaptchaError.unknown
        }

        var iconsRequest = URLRequest(url: URL(string: "https://image-drop-challenge.gameforge.com/challenge/\(challengeId)/en-GB/drag-icons")!)
        iconsRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        iconsRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (iconData, _) = try await session.data(for: iconsRequest)

        var textRequest = URLRequest(url: URL(string: "https://image-drop-challenge.gameforge.com/challenge/\(challengeId)/en-GB/text")!)
        textRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        textRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        let (textData, _) = try await session.data(for: textRequest)

        let hashes = hashes(forImageData: iconData, textData: textData)
        #warning("For now, we're just trying a random answer. Work In Progress.")
        let answer = Int.random(in: 0...3)

        var solveRequest = URLRequest(url: challengeURL!)
        solveRequest.httpMethod = "POST"
        solveRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        solveRequest.setValue("gzip, defalte, br", forHTTPHeaderField: "Accept-Encoding")
        solveRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        solveRequest.httpBody = try encoder.encode(CaptchaChallengeAnswer(answer: answer))

        let (solveData, _) = try await session.data(for: solveRequest)
        let solveStatus = try decoder.decode(CaptchaChallengeStatus.self, from: solveData)

        guard solveStatus.status == "solved" else { throw CaptchaError.unresolved }
    }

    private func hashes(forImageData imageData: Data, textData: Data) -> ([String], String) {
        let image = CIImage(data: imageData)

        var imageHashes: [String] = []
        let imageSize: CGFloat = 60
        for i in 0...3 {
            let crop: CIImage = image!.cropped(to: CGRect(x: imageSize * CGFloat(i), y: 0, width: imageSize, height: imageSize))
            let context = CIContext()
            let pngData = context.pngRepresentation(of: crop, format: .RGBA8, colorSpace: crop.colorSpace!)
            imageHashes.append(pngData!.md5)
        }

        return (imageHashes, textData.md5)
    }
}

extension Data {
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ =  self.withUnsafeBytes { bytes in
            CC_MD5(bytes, CC_LONG(self.count), &digest)
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
}
