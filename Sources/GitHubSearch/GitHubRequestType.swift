//
//  GitHubRequestType.swift
//  GitHubSearch
//
//  Created by Satoshi Nagasaka on 2017/10/10.
//

import Foundation
import APIKit

import Foundation
import APIKit

protocol GitHubRequest: Request {

}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension GitHubRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

struct SearchRepositoriesResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let id: Int
    let fullName: String

    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}

final class GitHubAPI {

    private init() {}

    struct SearchRepositories: GitHubRequest {
        typealias Response = SearchRepositoriesResponse

        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        var parameters: Any? {
            return ["q": query, "page": 1]
        }

        let query: String
    }
}
