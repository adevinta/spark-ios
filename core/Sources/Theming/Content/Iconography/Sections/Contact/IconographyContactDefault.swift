//
//  IconographyContactDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyContactDefault: IconographyContact {

    // MARK: - Properties

    public let voice: IconographyFill & IconographyOutlined
    public let voiceOff: IconographyFill & IconographyOutlined
    public let mail: IconographyFill & IconographyOutlined
    public let mailActif: IconographyFill & IconographyOutlined
    public let typing: IconographyFill & IconographyOutlined
    public let message: IconographyFill & IconographyOutlined
    public let conversation: IconographyFill & IconographyOutlined
    public let phone: IconographyImage
    public let call: IconographyImage
    public let support: IconographyImage
    public let support2: IconographyImage

    // MARK: - Initialization

    public init(voice: IconographyFill & IconographyOutlined,
                voiceOff: IconographyFill & IconographyOutlined,
                mail: IconographyFill & IconographyOutlined,
                mailActif: IconographyFill & IconographyOutlined,
                typing: IconographyFill & IconographyOutlined,
                message: IconographyFill & IconographyOutlined,
                conversation: IconographyFill & IconographyOutlined,
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
