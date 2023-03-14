//
//  IconographyCalendar.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyCalendar {
    var calendar: IconographyFilled & IconographyOutlined { get }
    var calendar2: IconographyFilled & IconographyOutlined { get }
    var calendarValid: IconographyFilled & IconographyOutlined { get }
}
