//
//  DataParser.swift
//  GitHubSearch
//
//  Created by Satoshi Nagasaka on 2017/10/10.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
