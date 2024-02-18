//
//  FavouriteItem.swift
//  FeedWorld
//
//  Created by Tanya Samastroyenka on 18.02.2024.
//

import CoreStore

final class FavouriteItem: CoreStoreObject, ImportableUniqueObject {
    typealias UniqueIDType = UUID
    typealias ImportSource = Dictionary<String, Any>
    
    @Field.Stored("id", dynamicInitialValue: { UUID() })
    var id: UUID
    
    static let uniqueIDKeyPath: String = String(keyPath: \FavouriteItem.$id)
    
    var uniqueIDValue: UniqueIDType {
        get { return self.id }
        set { self.id = newValue }
    }
    
    static func uniqueID(from source: ImportSource, in transaction: BaseDataTransaction) throws -> UniqueIDType? {
        let json = source
        
        return json["id"] as? UniqueIDType
    }
    
    func update(from source: ImportSource, in transaction: BaseDataTransaction) throws {
        
    }
}
