//
//  GitHubRepository.swift
//  GitHubSearch
//
//  Created by Satoshi Nagasaka on 2017/10/10.
//

import Foundation

class GitHubRepository: Decodable {
    var fullName: String?
    var ownerAvaterUrl: String?
    var updatedAt: String?
    var url: String?

    private enum CodingKeys: String, CodingKey {

        case fullName       = "full_name"
        case ownerAvaterUrl = "owner.avatar_url"
        case updatedAt      = "updated_at"
        case url            = "url"
    }
}
