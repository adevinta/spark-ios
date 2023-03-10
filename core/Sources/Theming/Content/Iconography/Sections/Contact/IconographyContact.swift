//
//  IconographyContact.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyContact {
    var voice: IconographyFill & IconographyOutlined { get }
    var voiceOff: IconographyFill & IconographyOutlined { get }
    var mail: IconographyFill & IconographyOutlined { get }
    var mailActif: IconographyFill & IconographyOutlined { get }
    var typing: IconographyFill & IconographyOutlined { get }
    var message: IconographyFill & IconographyOutlined { get }
    var conversation: IconographyFill & IconographyOutlined { get }
    // TODO: UI question: france ? three convesation image
    var phone: IconographyImage { get }
    var call: IconographyImage { get }
    var support: IconographyImage { get }
    var support2: IconographyImage { get }
}
