//
//  IconographyContactDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyContactDefault: IconographyContact {

    // MARK: - Properties

    public let voice: IconographyFilled & IconographyOutlined
    public let voiceOff: IconographyFilled & IconographyOutlined
    public let mail: IconographyFilled & IconographyOutlined
    public let mailActif: IconographyFilled & IconographyOutlined
    public let typing: IconographyFilled & IconographyOutlined
    public let message: IconographyFilled & IconographyOutlined
    // TODO: - Mutliple conversations?
    public let conversation: IconographyFilled & IconographyOutlined
    public let phone: IconographyImage
    public let call: IconographyImage
    public let support: IconographyImage
    public let support2: IconographyImage

    // MARK: - Initialization

    public init(voice: IconographyFilled & IconographyOutlined,
                voiceOff: IconographyFilled & IconographyOutlined,
                mail: IconographyFilled & IconographyOutlined,
                mailActif: IconographyFilled & IconographyOutlined,
                typing: IconographyFilled & IconographyOutlined,
                message: IconographyFilled & IconographyOutlined,
                conversation: IconographyFilled & IconographyOutlined,
                phone: IconographyImage, call: IconographyImage,
                support: IconographyImage,
                support2: IconographyImage) {
        self.voice = voice
        self.voiceOff = voiceOff
        self.mail = mail
        self.mailActif = mailActif
        self.typing = typing
        self.message = message
        self.conversation = conversation
        self.phone = phone
        self.call = call
        self.support = support
        self.support2 = support2
    }
}
