//
//  IconographyActions.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyActions {
    var calculate: IconographyFilled & IconographyOutlined { get }
    var copy: IconographyFilled & IconographyOutlined { get }
    var eye: IconographyFilled & IconographyOutlined { get }
    var eyeOff: IconographyFilled & IconographyOutlined { get }
    var like: IconographyFilled & IconographyOutlined { get }
    var moreMenu: IconographyVertical & IconographyHorizontal { get }
    var pen: IconographyFilled & IconographyOutlined { get }
    var print: IconographyFilled & IconographyOutlined { get }
    var trash: IconographyFilled & IconographyOutlined { get }
    var trashClose: IconographyFilled & IconographyOutlined { get }
    var wheel: IconographyFilled & IconographyOutlined { get }
    var flashlight: IconographyFilled & IconographyOutlined { get }
    var pause: IconographyFilled & IconographyOutlined { get }
    var play: IconographyFilled & IconographyOutlined { get }
    var refresh: IconographyImage { get }
    var search: IconographyImage { get }
    var scan: IconographyImage { get }
    var filter: IconographyImage { get }
}
