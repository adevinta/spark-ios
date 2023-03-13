//
//  IconographyContact.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyContact {
    var voice: IconographyFilled & IconographyOutlined { get }
    var voiceOff: IconographyFilled & IconographyOutlined { get }
    var mail: IconographyFilled & IconographyOutlined { get }
    var mailActif: IconographyFilled & IconographyOutlined { get }
    var typing: IconographyFilled & IconographyOutlined { get }
    var message: IconographyFilled & IconographyOutlined { get }
    var conversation: IconographyFilled & IconographyOutlined { get }
    var phone: IconographyImage { get }
    var call: IconographyImage { get }
    var support: IconographyImage { get }
    var support2: IconographyImage { get }
}
