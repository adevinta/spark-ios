//
//  IconographyNotificationsDefault.swift
//  Spark
//
//  Created by louis.borlee on 13/03/2023.
//

import Foundation

public struct IconographyNotificationsDefault: IconographyNotifications {

    // MARK: - Properties

    public let alarmOn: IconographyFill & IconographyOutlined
    public let alarmOff: IconographyFill & IconographyOutlined
    public let alarm: IconographyFill & IconographyOutlined
    public let notification: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(alarmOn: IconographyFill & IconographyOutlined,
                alarmOff: IconographyFill & IconographyOutlined,
                alarm: IconographyFill & IconographyOutlined,
                notification: IconographyFill & IconographyOutlined) {
        self.alarmOn = alarmOn
        self.alarmOff = alarmOff
        self.alarm = alarm
        self.notification = notification
    }
}
