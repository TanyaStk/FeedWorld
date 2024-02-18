//
//  FavoritesDataManager.swift
//  FeedWorld
//
//  Created by Tanya Samastroyenka on 18.02.2024.
//

import CoreStore

final class FavoriteItem: CoreStoreObject, ImportableUniqueObject {
    typealias UniqueIDType = UUID
    typealias ImportSource = Dictionary<String, Any>
    
    @Field.Stored("id", dynamicInitialValue: { UUID() })
    var id: UUID
    
    static let uniqueIDKeyPath: String = String(keyPath: \FavoriteItem.$id)
    
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

class FavoritesDataManager: ObservableObject {
    @Published var favorites = [UUID]()
    
    private let dataStack: DataStack = {
        let dataStack = DataStack(CoreStoreSchema(
            modelVersion: "V1",
            entities: [
                Entity<FavoriteItem>("FavoritesData"),
            ]
        ))
        
        return dataStack
    }()
    
    init() {
        _ = dataStack.addStorage(
            SQLiteStore(fileName: "FavoritesData.sqlite",
                        localStorageOptions: .allowSynchronousLightweightMigration)
        ) { [weak self] _ in self?.getAll() }
    }
    
    func save(_ id: UUID) {
        dataStack.perform(asynchronous: { transaction in
            let data = try transaction.importUniqueObject(
                Into<FavoriteItem>(),
                source: [FavoriteItem.uniqueIDKeyPath: id]
            )
        }, completion: { [weak self] _ in self?.getAll() })
    }
    
    func delete(_ id: UUID) {
        dataStack.perform(asynchronous: { transaction in
            try transaction.deleteAll(
                From<FavoriteItem>()
                    .where(\.$id == id)
            )
        },completion: { [weak self] _ in self?.getAll() })
    }
}

private extension FavoritesDataManager {
    func getAll() {
        do {
            let favorites = try dataStack.fetchAll(From<FavoriteItem>())
            self.favorites = favorites.map { $0.id }
        } catch {
            print("Error while fetching image's names")
            return
        }
    }
}
