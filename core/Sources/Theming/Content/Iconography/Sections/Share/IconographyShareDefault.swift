//
//  IconographyShareDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyShareDefault: IconographyShare {

    // MARK: - Properties

    public let `import`: IconographyImage
    public let export: IconographyImage
    public let facebook: IconographyFill & IconographyOutlined
    public let twitter: IconographyFill & IconographyOutlined
    public let share: IconographyFill & IconographyOutlined
    public let attachFile: IconographyImage
    public let link: IconographyImage
    public let forward: IconographyFill & IconographyOutlined
    public let instagram: IconographyFill & IconographyOutlined
    public let messenger: IconographyImage
    public let pinterest: IconographyImage
    public let whastapp: IconographyImage
    public let expand: IconographyImage
    public let shareIOS: IconographyImage

    // MARK: - Init

    public init(import: IconographyImage,
                export: IconographyImage,
                facebook: IconographyFill & IconographyOutlined,
                twitter: IconographyFill & IconographyOutlined,
                share: IconographyFill & IconographyOutlined,
                attachFile: IconographyImage,
                link: IconographyImage,
                forward: IconographyFill & IconographyOutlined,
                instagram: IconographyFill & IconographyOutlined,
                messenger: IconographyImage,
                pinterest: IconographyImage,
                whastapp: IconographyImage,
                expand: IconographyImage,
                shareIOS: IconographyImage) {
        self.`import` = `import`
        self.export = export
        self.facebook = facebook
        self.twitter = twitter
        self.share = share
        self.attachFile = attachFile
        self.link = link
        self.forward = forward
        self.instagram = instagram
        self.messenger = messenger
        self.pinterest = pinterest
        self.whastapp = whastapp
        self.expand = expand
        self.shareIOS = shareIOS
    }
}
