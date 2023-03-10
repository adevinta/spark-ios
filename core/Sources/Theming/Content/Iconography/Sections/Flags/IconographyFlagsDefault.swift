//
//  IconographyFlagsDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyFlagsDefault: IconographyFlags {

    // MARK: - Properties

    public let at: IconographyImage
    public let be: IconographyImage
    public let br: IconographyImage
    public let by: IconographyImage
    public let ch: IconographyImage
    public let cl: IconographyImage
    public let co: IconographyImage
    public let `do`: IconographyImage
    public let es: IconographyImage
    public let fi: IconographyImage
    public let fr: IconographyImage
    public let hu: IconographyImage
    public let id: IconographyImage
    public let ie: IconographyImage
    public let it: IconographyImage

    // MARK: - Initialization

    public init(at: IconographyImage,
                be: IconographyImage,
                br: IconographyImage,
                by: IconographyImage,
                ch: IconographyImage,
                cl: IconographyImage,
                co: IconographyImage,
                do: IconographyImage,
                es: IconographyImage,
                fi: IconographyImage,
                fr: IconographyImage,
                hu: IconographyImage,
                id: IconographyImage,
                ie: IconographyImage,
                it: IconographyImage) {
        self.at = at
        self.be = be
        self.br = br
        self.by = by
        self.ch = ch
        self.cl = cl
        self.co = co
        self.do = `do`
        self.es = es
        self.fi = fi
        self.fr = fr
        self.hu = hu
        self.id = id
        self.ie = ie
        self.it = it
    }
}
