//
//  ErrorModel.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let message: String
    let errors: [Error]
    let documentationURL: String

    enum CodingKeys: String, CodingKey {
        case message, errors
        case documentationURL = "documentation_url"
    }
}

// MARK: - Error
struct Error: Codable {
    let resource, field, code: String
}
