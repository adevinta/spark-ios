//
//  OtherView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct OtherView: View {

    // MARK: - Enum

    private enum Redirection: String, CaseIterable, Hashable {
        case theme
    }

    // MARK: - View

    var body: some View {
        NavigationStack {
            List(Redirection.allCases, id: \.self) { redirection in
                NavigationLink(redirection.name, value: redirection)
            }
            .navigationDestination(for: Redirection.self, destination: { redirection in
                switch redirection {
                case .theme : ThemeView()
                }
            })
            .navigationBarTitle("Other")
        }
    }
}

#Preview {
    OtherView()
}
