//
//  IconographyNotifications.swift
//  Spark
//
//  Created by louis.borlee on 13/03/2023.
//

import Foundation

public protocol IconographyNotifications {
    var alarmOn: IconographyFill & IconographyOutlined { get }
    var alarmOff: IconographyFill & IconographyOutlined { get }
    var alarm: IconographyFill & IconographyOutlined { get }
    var notification: IconographyFill & IconographyOutlined { get }
}
