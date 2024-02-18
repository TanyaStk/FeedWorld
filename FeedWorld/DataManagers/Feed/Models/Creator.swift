//
//  Creator.swift
//  FeedWorld
//

import Foundation

struct Creator: Decodable {
    let id: UUID
    let name: String
    let profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case profileImageUrl = "profile_pic"
    }
}
