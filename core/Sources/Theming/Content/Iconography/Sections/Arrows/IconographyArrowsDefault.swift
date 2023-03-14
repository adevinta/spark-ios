//
//  IconographyArrowsDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyArrowsDefault: IconographyArrows {

    // MARK: - Properties

    public let arrow: IconographyLeft & IconographyRight
    public let arrowDouble: IconographyLeft & IconographyRight
    public let arrowVertical: IconographyLeft & IconographyRight
    public let arrowHorizontal: IconographyUp & IconographyDown
    public let delete: IconographyFilled & IconographyOutlined
    public let graphArrow: IconographyUp & IconographyDown
    public let close: IconographyImage
    public let plus: IconographyImage

    // MARK: - Initialization

    public init(arrow: IconographyLeft & IconographyRight,
                arrowDouble: IconographyLeft & IconographyRight,
                arrowVertical: IconographyLeft & IconographyRight,
                arrowHorizontal: IconographyUp & IconographyDown,
                delete: IconographyFilled & IconographyOutlined,
                graphArrow: IconographyUp & IconographyDown,
                close: IconographyImage,
                plus: IconographyImage) {
        self.arrow = arrow
        self.arrowDouble = arrowDouble
        self.arrowVertical = arrowVertical
        self.arrowHorizontal = arrowHorizontal
        self.delete = delete
        self.graphArrow = graphArrow
        self.close = close
        self.plus = plus
    }
}
