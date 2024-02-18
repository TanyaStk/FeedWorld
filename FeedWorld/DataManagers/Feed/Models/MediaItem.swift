//
//  MediaItem.swift
//  FeedWorld
//

import Foundation

struct MediaItem: Decodable, Identifiable {
    let id: UUID
    let title: String
    let mediaType: MediaType
    let mediaUrl: String
    let viewCount: Int
    let creationDate: Date
    let creator: Creator
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case title
        case mediaType = "media_type"
        case mediaUrl = "media_url"
        case viewCount = "view_count"
        case creationDate = "created_on"
        case creator
    }
}

enum MediaType: String, Decodable {
    case image
    case video
}
