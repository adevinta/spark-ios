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
    public let facebook: IconographyFilled & IconographyOutlined
    public let twitter: IconographyFilled & IconographyOutlined
    public let share: IconographyFilled & IconographyOutlined
    public let attachFile: IconographyImage
    public let link: IconographyImage
    public let forward: IconographyFilled & IconographyOutlined
    public let instagram: IconographyFilled & IconographyOutlined
    public let messenger: IconographyImage
    public let pinterest: IconographyImage
    public let whastapp: IconographyImage
    public let expand: IconographyImage
    public let shareIOS: IconographyImage

    // MARK: - Init

    public init(import: IconographyImage,
                export: IconographyImage,
                facebook: IconographyFilled & IconographyOutlined,
                twitter: IconographyFilled & IconographyOutlined,
                share: IconographyFilled & IconographyOutlined,
                attachFile: IconographyImage,
                link: IconographyImage,
                forward: IconographyFilled & IconographyOutlined,
                instagram: IconographyFilled & IconographyOutlined,
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
