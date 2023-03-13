//
//  IconographyNotificationsDefault.swift
//  Spark
//
//  Created by louis.borlee on 13/03/2023.
//

import Foundation

public struct IconographyNotificationsDefault: IconographyNotifications {

    // MARK: - Properties

    public let alarmOn: IconographyFilled & IconographyOutlined
    public let alarmOff: IconographyFilled & IconographyOutlined
    public let alarm: IconographyFilled & IconographyOutlined
    public let notification: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(alarmOn: IconographyFilled & IconographyOutlined,
                alarmOff: IconographyFilled & IconographyOutlined,
                alarm: IconographyFilled & IconographyOutlined,
                notification: IconographyFilled & IconographyOutlined) {
        self.alarmOn = alarmOn
        self.alarmOff = alarmOff
        self.alarm = alarm
        self.notification = notification
    }
}
