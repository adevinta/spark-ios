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

    let primary: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                pressed: ColorTokenValueDefault(uiColor: .blue,
                                                                                swiftUIcolor: .blue),
                                                disabled: ColorTokenValueDefault(uiColor: .green,
                                                                                 swiftUIcolor: .green),
                                                on: ColorTokenValueDefault(uiColor: .yellow,
                                                                           swiftUIcolor: .yellow))
    let primaryVariant: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .yellow,
                                                                                       swiftUIcolor: .yellow),
                                                       pressed: ColorTokenValueDefault(uiColor: .red,
                                                                                       swiftUIcolor: .red),
                                                       disabled: ColorTokenValueDefault(uiColor: .purple,
                                                                                        swiftUIcolor: .purple),
                                                       on: ColorTokenValueDefault(uiColor: .gray,
                                                                                  swiftUIcolor: .gray))

    let secondary: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .black,
                                                                                  swiftUIcolor: .black),
                                                  pressed: ColorTokenValueDefault(uiColor: .white,
                                                                                  swiftUIcolor: .white),
                                                  disabled: ColorTokenValueDefault(uiColor: .red,
                                                                                   swiftUIcolor: .red),
                                                  on: ColorTokenValueDefault(uiColor: .yellow,
                                                                             swiftUIcolor: .yellow))
    let secondaryVariant: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                          swiftUIcolor: .orange),
                                                         on: ColorTokenValueDefault(uiColor: .orange,
                                                                                    swiftUIcolor: .orange))

    let background: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                   swiftUIcolor: .orange),
                                                   pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                   swiftUIcolor: .orange),
                                                   disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                    swiftUIcolor: .orange),
                                                   on: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange))

    let surface: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                 swiftUIcolor: .orange),
                                                on: ColorTokenValueDefault(uiColor: .orange,
                                                                           swiftUIcolor: .orange))
    let surfaceInverse: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                        swiftUIcolor: .orange),
                                                       on: ColorTokenValueDefault(uiColor: .orange,
                                                                                  swiftUIcolor: .orange))

    let success: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                 swiftUIcolor: .orange),
                                                on: ColorTokenValueDefault(uiColor: .orange,
                                                                           swiftUIcolor: .orange))
    let alert: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange),
                                              pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange),
                                              disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                               swiftUIcolor: .orange),
                                              on: ColorTokenValueDefault(uiColor: .orange,
                                                                         swiftUIcolor: .orange))
    let error: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange),
                                              pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange),
                                              disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                               swiftUIcolor: .orange),
                                              on: ColorTokenValueDefault(uiColor: .orange,
                                                                         swiftUIcolor: .orange))
    let info: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                             swiftUIcolor: .orange),
                                             pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                             swiftUIcolor: .orange),
                                             disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                              swiftUIcolor: .orange),
                                             on: ColorTokenValueDefault(uiColor: .orange,
                                                                        swiftUIcolor: .orange))
    let neutral: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                swiftUIcolor: .orange),
                                                disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                 swiftUIcolor: .orange),
                                                on: ColorTokenValueDefault(uiColor: .orange,
                                                                           swiftUIcolor: .orange))

    let primaryContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                          swiftUIcolor: .orange),
                                                         on: ColorTokenValueDefault(uiColor: .orange,
                                                                                    swiftUIcolor: .orange))
    let secondaryContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                           swiftUIcolor: .orange),
                                                           pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                           swiftUIcolor: .orange),
                                                           disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                            swiftUIcolor: .orange),
                                                           on: ColorTokenValueDefault(uiColor: .orange,
                                                                                      swiftUIcolor: .orange))
    let successContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                          swiftUIcolor: .orange),
                                                         on: ColorTokenValueDefault(uiColor: .orange,
                                                                                    swiftUIcolor: .orange))
    let alertContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                        swiftUIcolor: .orange),
                                                       on: ColorTokenValueDefault(uiColor: .orange,
                                                                                  swiftUIcolor: .orange))
    let errorContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                       disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                        swiftUIcolor: .orange),
                                                       on: ColorTokenValueDefault(uiColor: .orange,
                                                                                  swiftUIcolor: .orange))
    let infoContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                      swiftUIcolor: .orange),
                                                      pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                      swiftUIcolor: .orange),
                                                      disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                       swiftUIcolor: .orange),
                                                      on: ColorTokenValueDefault(uiColor: .orange,
                                                                                 swiftUIcolor: .orange))
    let neutralContainer: ColorToken = ColorTokenDefault(enabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         pressed: ColorTokenValueDefault(uiColor: .orange,
                                                                                         swiftUIcolor: .orange),
                                                         disabled: ColorTokenValueDefault(uiColor: .orange,
                                                                                          swiftUIcolor: .orange),
                                                         on: ColorTokenValueDefault(uiColor: .orange,
                                                                                    swiftUIcolor: .orange))
}
