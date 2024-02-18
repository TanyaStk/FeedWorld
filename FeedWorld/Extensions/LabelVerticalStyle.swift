//
//  LabelVerticalStyle.swift
//  FeedWorld
//

import SwiftUI

struct VerticalStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.icon
            configuration.title
        }
    }
}
