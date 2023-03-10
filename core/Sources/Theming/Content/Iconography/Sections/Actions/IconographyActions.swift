//
//  IconographyActions.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyActions {
    var calculate: IconographyFill & IconographyOutlined { get }
    var copy: IconographyFill & IconographyOutlined { get }
    var eye: IconographyFill & IconographyOutlined { get }
    var eyeOff: IconographyFill & IconographyOutlined { get }
    var like: IconographyFill & IconographyOutlined { get }
    var moreMenu: IconographyVertical & IconographyHorizontal { get }
    var pen: IconographyFill & IconographyOutlined { get }
    var print: IconographyFill & IconographyOutlined { get }
    var trash: IconographyFill & IconographyOutlined { get }
    var trashClose: IconographyFill & IconographyOutlined { get }
    var wheel: IconographyFill & IconographyOutlined { get }
    var flashlight: IconographyFill & IconographyOutlined { get }
    var pause: IconographyFill & IconographyOutlined { get }
    var play: IconographyFill & IconographyOutlined { get }
    var refresh: IconographyImage { get }
    var search: IconographyImage { get }
    var scan: IconographyImage { get }
    var filter: IconographyImage { get }
}
