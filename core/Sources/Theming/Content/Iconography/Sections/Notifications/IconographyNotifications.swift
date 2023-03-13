//
//  IconographyNotifications.swift
//  Spark
//
//  Created by louis.borlee on 13/03/2023.
//

import Foundation

public protocol IconographyNotifications {
    var alarmOn: IconographyFilled & IconographyOutlined { get }
    var alarmOff: IconographyFilled & IconographyOutlined { get }
    var alarm: IconographyFilled & IconographyOutlined { get }
    var notification: IconographyFilled & IconographyOutlined { get }
}
