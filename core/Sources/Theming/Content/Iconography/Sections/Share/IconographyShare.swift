//
//  IconographyShare.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyShare {
    var `import`: IconographyImage { get }
    var export: IconographyImage { get }
    var facebook: IconographyFilled & IconographyOutlined { get }
    var twitter: IconographyFilled & IconographyOutlined { get }
    var share: IconographyFilled & IconographyOutlined { get }
    var attachFile: IconographyImage { get }
    var link: IconographyImage { get }
    var forward: IconographyFilled & IconographyOutlined { get }
    var instagram: IconographyFilled & IconographyOutlined { get }
    var messenger: IconographyImage { get }
    var pinterest: IconographyImage { get }
    var whastapp: IconographyImage { get }
    var expand: IconographyImage { get }
    var shareIOS: IconographyImage { get }
}
