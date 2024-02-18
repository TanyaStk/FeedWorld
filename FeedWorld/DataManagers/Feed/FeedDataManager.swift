//
//  FeedDataManager.swift
//  FeedWorld
//

import Foundation

final class FeedDataManager: ObservableObject {
    
    @Published var items = [ItemType]()
    
    init() {
        getData()
    }
    
    func getData() {
        guard let fileURL = Bundle.main.url(
            forResource: "feed",
            withExtension: "json") else { return }
        
        do {
            if let jsonData = try String(contentsOf: fileURL).data(using: .utf8) {
                let decodedItems = try JSONDecoder().decode(Items.self, from: jsonData)
                items = decodedItems.items.compactMap { $0 }
            } else {
                print("Given JSON is not a valid dictionary object.")
            }
        } catch {
            print(error)
        }
    }
}
