//
//  APIManager.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import Foundation

protocol APIManagerProtocol {
    func initRequest<T: Decodable>(with request: RequestProtocol) async throws -> T
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func initRequest<T: Decodable>(with request: RequestProtocol) async throws -> T {
        let (data, response) = try await urlSession.data(for: request.request())

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
}
