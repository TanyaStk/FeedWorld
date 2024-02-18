//
//  FavouritesDataManager.swift
//  FeedWorld
//
//  Created by Tanya Samastroyenka on 18.02.2024.
//

import CoreStore

class FavouritesDataManager: ObservableObject {
    @Published var favorites = [UUID]()
    
    private let dataStack: DataStack = {
        let dataStack = DataStack(CoreStoreSchema(
            modelVersion: "V1",
            entities: [
                Entity<FavouriteItem>("FavoyritesData"),
            ]
        ))
        
        return dataStack
    }()
    
    init() {
        _ = dataStack.addStorage(
            SQLiteStore(fileName: "FavoyritesData.sqlite",
                        localStorageOptions: .allowSynchronousLightweightMigration)
        ) { [weak self] _ in self?.getAll() }
    }
    
    func save(_ id: UUID) {
        dataStack.perform(asynchronous: { transaction in
            let data = try transaction.importUniqueObject(
                Into<FavouriteItem>(),
                source: [FavouriteItem.uniqueIDKeyPath: id]
            )
        }, completion: { [weak self] _ in self?.getAll() })
    }
    
    func delete(_ id: UUID) {
        dataStack.perform(asynchronous: { transaction in
            try transaction.deleteAll(
                From<FavouriteItem>()
                    .where(\.$id == id)
            )
        },completion: { [weak self] _ in self?.getAll() })
    }
}

private extension FavouritesDataManager {
    func getAll() {
        do {
            let favorites = try dataStack.fetchAll(From<FavouriteItem>())
            self.favorites = favorites.map { $0.id }
        } catch {
            print("Error while fetching image's names")
            return
        }
    }
}
