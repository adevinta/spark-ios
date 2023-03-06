//
//  SparkColors.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore

// TODO:

struct SparkColors: Colors {

    // MARK: - Properties

    let primary: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    pressed: .init(uiColor: .blue,
                                                   swiftUIcolor: .blue),
                                    disabled: .init(uiColor: .green,
                                                    swiftUIcolor: .green),
                                    on: .init(uiColor: .yellow,
                                              swiftUIcolor: .yellow))
    let primaryVariant: ColorToken = .init(enabled: .init(uiColor: .yellow,
                                                          swiftUIcolor: .yellow),
                                           pressed: .init(uiColor: .red,
                                                          swiftUIcolor: .red),
                                           disabled: .init(uiColor: .purple,
                                                           swiftUIcolor: .purple),
                                           on: .init(uiColor: .gray,
                                                     swiftUIcolor: .gray))

    let secondary: ColorToken = .init(enabled: .init(uiColor: .black,
                                                     swiftUIcolor: .black),
                                      pressed: .init(uiColor: .white,
                                                     swiftUIcolor: .white),
                                      disabled: .init(uiColor: .red,
                                                      swiftUIcolor: .red),
                                      on: .init(uiColor: .yellow,
                                                swiftUIcolor: .yellow))
    let secondaryVariant: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             pressed: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             disabled: .init(uiColor: .orange,
                                                             swiftUIcolor: .orange),
                                             on: .init(uiColor: .orange,
                                                       swiftUIcolor: .orange))

    let background: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                      swiftUIcolor: .orange),
                                       pressed: .init(uiColor: .orange,
                                                      swiftUIcolor: .orange),
                                       disabled: .init(uiColor: .orange,
                                                       swiftUIcolor: .orange),
                                       on: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange))

    let surface: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    pressed: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    disabled: .init(uiColor: .orange,
                                                    swiftUIcolor: .orange),
                                    on: .init(uiColor: .orange,
                                              swiftUIcolor: .orange))
    let surfaceInverse: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           pressed: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           disabled: .init(uiColor: .orange,
                                                           swiftUIcolor: .orange),
                                           on: .init(uiColor: .orange,
                                                     swiftUIcolor: .orange))

    let success: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    pressed: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    disabled: .init(uiColor: .orange,
                                                    swiftUIcolor: .orange),
                                    on: .init(uiColor: .orange,
                                              swiftUIcolor: .orange))
    let alert: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange),
                                  pressed: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange),
                                  disabled: .init(uiColor: .orange,
                                                  swiftUIcolor: .orange),
                                  on: .init(uiColor: .orange,
                                            swiftUIcolor: .orange))
    let error: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange),
                                  pressed: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange),
                                  disabled: .init(uiColor: .orange,
                                                  swiftUIcolor: .orange),
                                  on: .init(uiColor: .orange,
                                            swiftUIcolor: .orange))
    let info: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                swiftUIcolor: .orange),
                                 pressed: .init(uiColor: .orange,
                                                swiftUIcolor: .orange),
                                 disabled: .init(uiColor: .orange,
                                                 swiftUIcolor: .orange),
                                 on: .init(uiColor: .orange,
                                           swiftUIcolor: .orange))
    let neutral: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    pressed: .init(uiColor: .orange,
                                                   swiftUIcolor: .orange),
                                    disabled: .init(uiColor: .orange,
                                                    swiftUIcolor: .orange),
                                    on: .init(uiColor: .orange,
                                              swiftUIcolor: .orange))

    let primaryContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             pressed: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             disabled: .init(uiColor: .orange,
                                                             swiftUIcolor: .orange),
                                             on: .init(uiColor: .orange,
                                                       swiftUIcolor: .orange))
    let secondaryContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                              swiftUIcolor: .orange),
                                               pressed: .init(uiColor: .orange,
                                                              swiftUIcolor: .orange),
                                               disabled: .init(uiColor: .orange,
                                                               swiftUIcolor: .orange),
                                               on: .init(uiColor: .orange,
                                                         swiftUIcolor: .orange))
    let successContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             pressed: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             disabled: .init(uiColor: .orange,
                                                             swiftUIcolor: .orange),
                                             on: .init(uiColor: .orange,
                                                       swiftUIcolor: .orange))
    let alertContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           pressed: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           disabled: .init(uiColor: .orange,
                                                           swiftUIcolor: .orange),
                                           on: .init(uiColor: .orange,
                                                     swiftUIcolor: .orange))
    let errorContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           pressed: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                           disabled: .init(uiColor: .orange,
                                                           swiftUIcolor: .orange),
                                           on: .init(uiColor: .orange,
                                                     swiftUIcolor: .orange))
    let infoContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                         swiftUIcolor: .orange),
                                          pressed: .init(uiColor: .orange,
                                                         swiftUIcolor: .orange),
                                          disabled: .init(uiColor: .orange,
                                                          swiftUIcolor: .orange),
                                          on: .init(uiColor: .orange,
                                                    swiftUIcolor: .orange))
    let neutralContainer: ColorToken = .init(enabled: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             pressed: .init(uiColor: .orange,
                                                            swiftUIcolor: .orange),
                                             disabled: .init(uiColor: .orange,
                                                             swiftUIcolor: .orange),
                                             on: .init(uiColor: .orange,
                                                       swiftUIcolor: .orange))
}
