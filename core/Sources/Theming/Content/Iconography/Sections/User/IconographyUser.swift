//
//  IconographyUser.swift
//  Spark
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyUser {
    var verified: IconographyFilled & IconographyOutlined { get }
    var warningSecurity: IconographyFilled & IconographyOutlined { get }
    var security: IconographyFilled & IconographyOutlined { get }
    var profile: IconographyFilled & IconographyOutlined { get }
    var securityProfile: IconographyFilled & IconographyOutlined { get }
    var securityProfile2: IconographyFilled & IconographyOutlined { get }
    var userCheck: IconographyFilled & IconographyOutlined { get }
    var account: IconographyFilled & IconographyOutlined { get }
    var pro: IconographyFilled & IconographyOutlined { get }
    var group: IconographyFilled & IconographyOutlined { get }
}
