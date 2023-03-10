//
//  IconographyActionsDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyActionsDefault: IconographyActions {

    // MARK: - Properties

    public let calculate: IconographyFill & IconographyOutlined
    public let copy: IconographyFill & IconographyOutlined
    public let eye: IconographyFill & IconographyOutlined
    public let eyeOff: IconographyFill & IconographyOutlined
    public let like: IconographyFill & IconographyOutlined
    public let moreMenu: IconographyVertical & IconographyHorizontal
    public let pen: IconographyFill & IconographyOutlined
    public let print: IconographyFill & IconographyOutlined
    public let trash: IconographyFill & IconographyOutlined
    public let trashClose: IconographyFill & IconographyOutlined
    public let wheel: IconographyFill & IconographyOutlined
    public let flashlight: IconographyFill & IconographyOutlined
    public let pause: IconographyFill & IconographyOutlined
    public let play: IconographyFill & IconographyOutlined
    public let refresh: IconographyImage
    public let search: IconographyImage
    public let scan: IconographyImage
    public let filter: IconographyImage

    // MARK: - Initialization

    public init(calculate: IconographyFill & IconographyOutlined,
                copy: IconographyFill & IconographyOutlined,
                eye: IconographyFill & IconographyOutlined,
                eyeOff: IconographyFill & IconographyOutlined,
                like: IconographyFill & IconographyOutlined,
                moreMenu: IconographyVertical & IconographyHorizontal,
                pen: IconographyFill & IconographyOutlined,
                print: IconographyFill & IconographyOutlined,
                trash: IconographyFill & IconographyOutlined,
                trashClose: IconographyFill & IconographyOutlined,
                wheel: IconographyFill & IconographyOutlined,
                flashlight: IconographyFill & IconographyOutlined,
                pause: IconographyFill & IconographyOutlined,
                play: IconographyFill & IconographyOutlined,
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
