//
//  PokeListAPI.swift
//  ios-architecture
//
//  Created by AIR on 2023/04/20.
//

import Foundation


public class PokeListAPI {
    private let apiClient: APIClient
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    let request = PokeListAPIRequest()
    
    func requestPokeList(completion: @escaping (Result<PokemonListResponse, APIError>) -> Void) {
        apiClient.request(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct PokeListAPIRequest: Requestable {
    typealias Model = PokemonListResponse
    
    var url: String {
        return "https://pokeapi.co/api/v2/pokemon/"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var body: Data? {
        return nil
    }
    
    var queries: [String: String] {
        return ["limit": "1281"]
    }
    
    var timeout: TimeInterval {
        return 60
    }
    
    func decode(from data: Data) throws -> PokemonListResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(PokemonListResponse.self, from: data)
    }
    
}