//
//  SwitchTypeAlias.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

public typealias SwitchUIVariantImages = (on: UIImage, off: UIImage)
public typealias SwitchVariantImages = (on: Image, off: Image)

typealias SwitchImage = Either<UIImage, Image>
typealias SwitchAttributedString = Either<NSAttributedString, AttributedString>
