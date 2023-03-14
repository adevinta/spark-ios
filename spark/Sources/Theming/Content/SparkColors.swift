//
//  SparkColors.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore
import UIKit
import SwiftUI

// TODO:
struct ColorTokenValueCustom: ColorTokenValue {

    let uiColor: UIColor
    let swiftUIColor: Color

    init(uiColor: UIColor,
         swiftUIColor: Color) {
        self.uiColor = uiColor
        self.swiftUIColor = swiftUIColor
    }
}

struct SparkColors: Colors {

    // MARK: - Properties

    let primary: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                pressed: ColorTokenValueCustom(uiColor: .blue,
                                                                               swiftUIColor: .blue),
                                                disabled: ColorTokenValueCustom(uiColor: .green,
                                                                                swiftUIColor: .green),
                                                on: ColorTokenValueCustom(uiColor: .yellow,
                                                                          swiftUIColor: .yellow))
    let primaryVariant: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .yellow,
                                                                                      swiftUIColor: .yellow),
                                                       pressed: ColorTokenValueCustom(uiColor: .red,
                                                                                      swiftUIColor: .red),
                                                       disabled: ColorTokenValueCustom(uiColor: .purple,
                                                                                       swiftUIColor: .purple),
                                                       on: ColorTokenValueCustom(uiColor: .gray,
                                                                                 swiftUIColor: .gray))

    let secondary: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .black,
                                                                                 swiftUIColor: .black),
                                                  pressed: ColorTokenValueCustom(uiColor: .white,
                                                                                 swiftUIColor: .white),
                                                  disabled: ColorTokenValueCustom(uiColor: .red,
                                                                                  swiftUIColor: .red),
                                                  on: ColorTokenValueCustom(uiColor: .yellow,
                                                                            swiftUIColor: .yellow))
    let secondaryVariant: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                         swiftUIColor: .orange),
                                                         on: ColorTokenValueCustom(uiColor: .orange,
                                                                                   swiftUIColor: .orange))

    let background: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                  swiftUIColor: .orange),
                                                   pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                  swiftUIColor: .orange),
                                                   disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                   swiftUIColor: .orange),
                                                   on: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange))

    let surface: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                swiftUIColor: .orange),
                                                on: ColorTokenValueCustom(uiColor: .orange,
                                                                          swiftUIColor: .orange))
    let surfaceInverse: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                       swiftUIColor: .orange),
                                                       on: ColorTokenValueCustom(uiColor: .orange,
                                                                                 swiftUIColor: .orange))

    let success: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                swiftUIColor: .orange),
                                                on: ColorTokenValueCustom(uiColor: .orange,
                                                                          swiftUIColor: .orange))
    let alert: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange),
                                              pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange),
                                              disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                              swiftUIColor: .orange),
                                              on: ColorTokenValueCustom(uiColor: .orange,
                                                                        swiftUIColor: .orange))
    let error: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange),
                                              pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange),
                                              disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                              swiftUIColor: .orange),
                                              on: ColorTokenValueCustom(uiColor: .orange,
                                                                        swiftUIColor: .orange))
    let info: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                            swiftUIColor: .orange),
                                             pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                            swiftUIColor: .orange),
                                             disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                             swiftUIColor: .orange),
                                             on: ColorTokenValueCustom(uiColor: .orange,
                                                                       swiftUIColor: .orange))
    let neutral: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                               swiftUIColor: .orange),
                                                disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                swiftUIColor: .orange),
                                                on: ColorTokenValueCustom(uiColor: .orange,
                                                                          swiftUIColor: .orange))

    let primaryContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                         swiftUIColor: .orange),
                                                         on: ColorTokenValueCustom(uiColor: .orange,
                                                                                   swiftUIColor: .orange))
    let secondaryContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                          swiftUIColor: .orange),
                                                           pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                          swiftUIColor: .orange),
                                                           disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                           swiftUIColor: .orange),
                                                           on: ColorTokenValueCustom(uiColor: .orange,
                                                                                     swiftUIColor: .orange))
    let successContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                         swiftUIColor: .orange),
                                                         on: ColorTokenValueCustom(uiColor: .orange,
                                                                                   swiftUIColor: .orange))
    let alertContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                       swiftUIColor: .orange),
                                                       on: ColorTokenValueCustom(uiColor: .orange,
                                                                                 swiftUIColor: .orange))
    let errorContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                       disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                       swiftUIColor: .orange),
                                                       on: ColorTokenValueCustom(uiColor: .orange,
                                                                                 swiftUIColor: .orange))
    let infoContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                     swiftUIColor: .orange),
                                                      pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                     swiftUIColor: .orange),
                                                      disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                      swiftUIColor: .orange),
                                                      on: ColorTokenValueCustom(uiColor: .orange,
                                                                                swiftUIColor: .orange))
    let neutralContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         pressed: ColorTokenValueCustom(uiColor: .orange,
                                                                                        swiftUIColor: .orange),
                                                         disabled: ColorTokenValueCustom(uiColor: .orange,
                                                                                         swiftUIColor: .orange),
                                                         on: ColorTokenValueCustom(uiColor: .orange,
                                                                                   swiftUIColor: .orange))
}
