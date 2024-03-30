//
//  Service.swift
//  Services
//
//  Created by Alexandr Onischenko on 30.03.2024.
//

import Foundation

// MARK: - ServiceMessage
struct ServiceMessage: Codable {
    let body: Body
    let status: Int
}

// MARK: - Body
struct Body: Codable {
    let services: [Service]
}

// MARK: - Service
struct Service: Codable {
    let name, description: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
