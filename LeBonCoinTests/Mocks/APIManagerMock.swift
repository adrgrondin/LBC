//
//  APIManagerMock.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 28/04/2022.
//

import XCTest
@testable import LeBonCoin

struct APIManagerMock: APIManagerProtocol {
    func initRequest<T: Decodable>(with request: RequestProtocol) async throws -> T {
        let data = try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}
