//
//  BottomSheetView.swift
//  SparkDemo
//
//  Created by alican.aycil on 06.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct BottomSheetView: View {

    // MARK: - Properties
    @State private var isBottomSheetPresented: Bool = false
    @State private var bottomSheetHeight: CGFloat = 0

    // MARK: - View

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {

                if #available(iOS 16.0, *) {
                    Button {
                        self.isBottomSheetPresented.toggle()
                    } label: {
                        Text("Button")
                    }
                    .sheet(isPresented: $isBottomSheetPresented) {
                        GeometryReader { geo in
                            VStack{
                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                                .frame(width: UIScreen.main.bounds.size.width - 40)
                                .fixedSize()
                            }
                            .padding(20)
                            .overlay(
                                GeometryReader { geo in
                                    Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
                                }
                            )
                            .onPreferenceChange(HeightPreferenceKey.self) {
                                self.bottomSheetHeight = $0 ?? 0
                            }
                            .presentationDetents([.height(self.bottomSheetHeight)])
                            .presentationDragIndicator(.hidden)
//                            .presentationCornerRadius(21) available over 16.4
                        }
                    }
                } else {
                    Button {
                        self.isBottomSheetPresented.toggle()
                    } label: {
                        Text("Button")
                    }
                    .sheet(isPresented: $isBottomSheetPresented) {
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                    }
                }
            }
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
