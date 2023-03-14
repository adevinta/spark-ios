//
//  IconographyActionsDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyActionsDefault: IconographyActions {

    // MARK: - Properties

    public let calculate: IconographyFilled & IconographyOutlined
    public let copy: IconographyFilled & IconographyOutlined
    public let eye: IconographyFilled & IconographyOutlined
    public let eyeOff: IconographyFilled & IconographyOutlined
    public let like: IconographyFilled & IconographyOutlined
    public let moreMenu: IconographyVertical & IconographyHorizontal
    public let pen: IconographyFilled & IconographyOutlined
    public let print: IconographyFilled & IconographyOutlined
    public let trash: IconographyFilled & IconographyOutlined
    public let trashClose: IconographyFilled & IconographyOutlined
    public let wheel: IconographyFilled & IconographyOutlined
    public let flashlight: IconographyFilled & IconographyOutlined
    public let pause: IconographyFilled & IconographyOutlined
    public let play: IconographyFilled & IconographyOutlined
    public let refresh: IconographyImage
    public let search: IconographyImage
    public let scan: IconographyImage
    public let filter: IconographyImage

    // MARK: - Initialization

    public init(calculate: IconographyFilled & IconographyOutlined,
                copy: IconographyFilled & IconographyOutlined,
                eye: IconographyFilled & IconographyOutlined,
                eyeOff: IconographyFilled & IconographyOutlined,
                like: IconographyFilled & IconographyOutlined,
                moreMenu: IconographyVertical & IconographyHorizontal,
                pen: IconographyFilled & IconographyOutlined,
                print: IconographyFilled & IconographyOutlined,
                trash: IconographyFilled & IconographyOutlined,
                trashClose: IconographyFilled & IconographyOutlined,
                wheel: IconographyFilled & IconographyOutlined,
                flashlight: IconographyFilled & IconographyOutlined,
                pause: IconographyFilled & IconographyOutlined,
                play: IconographyFilled & IconographyOutlined,
                refresh: IconographyImage,
                search: IconographyImage,
                scan: IconographyImage,
                filter: IconographyImage) {
        self.calculate = calculate
        self.copy = copy
        self.eye = eye
        self.eyeOff = eyeOff
        self.like = like
        self.moreMenu = moreMenu
        self.pen = pen
        self.print = print
        self.trash = trash
        self.trashClose = trashClose
        self.wheel = wheel
        self.flashlight = flashlight
        self.pause = pause
        self.play = play
        self.refresh = refresh
        self.search = search
        self.scan = scan
        self.filter = filter
    }
}
