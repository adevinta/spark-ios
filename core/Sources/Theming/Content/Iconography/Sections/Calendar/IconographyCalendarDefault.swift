//
//  IconographyCalendarDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyCalendarDefault: IconographyCalendar {

    // MARK: - Properties

    public let calendar: IconographyFilled & IconographyOutlined
    public let calendar2: IconographyFilled & IconographyOutlined
    public let calendarValid: IconographyFilled & IconographyOutlined

    // MARK: - Initialization

    public init(calendar: IconographyFilled & IconographyOutlined,
                calendar2: IconographyFilled & IconographyOutlined,
                calendarValid: IconographyFilled & IconographyOutlined) {
        self.calendar = calendar
        self.calendar2 = calendar2
        self.calendarValid = calendarValid
    }
}
