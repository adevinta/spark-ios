//
//  IconographyCalendar.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyCalendar {
    var calendar: IconographyFill & IconographyOutlined { get }
    var calendar2: IconographyFill & IconographyOutlined { get }
    var calendarValid: IconographyFill & IconographyOutlined { get }
}
