//
//  ContentView.swift
//  SparkCoreDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

struct ContentView: View {

    private let theme = SparkTheme.shared

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(theme.colors.secondary.secondary.color)
            Text("Hello, Spark Core Demo!")
                .font(theme.typography.display1.font)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
