//
//  PromoItem.swift
//  FeedWorld
//

import Foundation

struct PromoItem: Decodable {
    var id: UUID
    var title: String
    let backgroundColor: String
    let buttonText: String
    let buttonUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case title
        case backgroundColor = "background_color"
        case buttonText = "button_text"
        case buttonUrl = "button_url"
    }
}
