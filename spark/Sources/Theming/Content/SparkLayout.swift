//
//  SparkLayout.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore

struct SparkLayout: Layout {
    
    // MARK: - Properties
    
    let spacing: LayoutSpacing = LayoutSpacingDefault(small: 4,
                                                      medium: 8,
                                                      large: 16,
                                                      xLarge: 24,
                                                      xxLarge: 32,
                                                      xxxLarge: 40)
}
