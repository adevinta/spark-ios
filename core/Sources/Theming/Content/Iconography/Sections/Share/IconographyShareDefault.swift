//
//  IconographyShareDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

struct IconographyShareDefault: IconographyShare {

    // MARK: - Properties

    let `import`: IconographyImage
    let export: IconographyImage
    let facebook: IconographyFill & IconographyOutlined
    let twitter: IconographyFill & IconographyOutlined
    let share: IconographyFill & IconographyOutlined
    let attachFile: IconographyImage
    let link: IconographyImage
    let forward: IconographyFill & IconographyOutlined
    let instagram: IconographyFill & IconographyOutlined
    let messenger: IconographyImage
    let pinterest: IconographyImage
    let whastapp: IconographyImage
    let expand: IconographyImage
    let shareIOS: IconographyImage

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
