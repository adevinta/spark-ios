//
//  IconographyCalendarDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyCalendarDefault: IconographyCalendar {

    // MARK: - Properties

    public let calendar: IconographyFill & IconographyOutlined
    public let calendar2: IconographyFill & IconographyOutlined
    public let calendarValid: IconographyFill & IconographyOutlined

    // MARK: - Initialization

    public init(calendar: IconographyFill & IconographyOutlined,
                calendar2: IconographyFill & IconographyOutlined,
                calendarValid: IconographyFill & IconographyOutlined) {
        self.calendar = calendar
        self.calendar2 = calendar2
        self.calendarValid = calendarValid
    }
}
