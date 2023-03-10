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
    var facebook: IconographyFill & IconographyOutlined { get }
    var twitter: IconographyFill & IconographyOutlined { get }
    var share: IconographyFill & IconographyOutlined { get }
    var attachFile: IconographyImage { get }
    var link: IconographyImage { get }
    var forward: IconographyFill & IconographyOutlined { get }
    var instagram: IconographyFill & IconographyOutlined { get }
    var messenger: IconographyImage { get }
    var pinterest: IconographyImage { get }
    var whastapp: IconographyImage { get }
    var expand: IconographyImage { get }
    var shareIOS: IconographyImage { get }
}
