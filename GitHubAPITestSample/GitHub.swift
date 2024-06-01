//
//  GitHub.swift
//  GitHubAPITestSample
//
//  Created by sako0602 on 2024/06/01.
//

import Foundation

protocol GitHubAPIRepositoryProtocol {
    func fetch() -> [GitHubRepository]
}

struct GitHubRepository: Decodable {
    let id: Int
    let name: String
    let stargazersCount: Int
}

struct GitHubAPIRepository{
    init?(user: String) {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else { return nil }
        self.url = url
    }
    let url: URL
    
    func fetch() async throws -> [GitHubRepository] {
        let (data,_) = try await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode([GitHubRepository].self, from: data)
    }
    //test
    //test2
}


