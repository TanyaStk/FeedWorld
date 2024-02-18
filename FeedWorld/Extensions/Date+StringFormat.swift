//
//  Date+StringFormat.swift
//  FeedWorld
//
//  Created by Tanya Samastroyenka on 18.02.2024.
//

import Foundation

extension Date {
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = .current
        
        return formatter.string(from: self)
    }
}
