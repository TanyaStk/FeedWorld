//
//  Items.swift
//  FeedWorld
//

import Foundation

struct Items: Decodable {
    let items: [ItemType?]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var items = [ItemType?]()
        
        while !itemsContainer.isAtEnd {
            let itemDecoder = try itemsContainer.superDecoder()
            let itemType = try? ItemType(from: itemDecoder)
            items.append(itemType)
        }
        self.items = items
    }
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Item: Decodable {
    let id: UUID
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case mediaType = "media_type"
    }
}

enum ItemType: Decodable, Identifiable {
    case media(MediaItem)
    case promo(PromoItem)
    
    var id: UUID {
        switch self {
        case .media(let mediaItem):
            return mediaItem.id
        case .promo(let promoItem):
            return promoItem.id
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mediaType = try? container.decode(Item.self)
        switch mediaType?.mediaType {
        case "video", "image":
            let mediaItem = try container.decode(MediaItem.self)
            self = .media(mediaItem)
        case "promo":
            let promoItem = try container.decode(PromoItem.self)
            self = .promo(promoItem)
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid type")
        }
    }
}
