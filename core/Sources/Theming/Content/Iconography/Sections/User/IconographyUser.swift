//
//  IconographyUser.swift
//  Spark
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyUser {
    var verified: IconographyFill & IconographyOutlined { get }
    var warningSecurity: IconographyFill & IconographyOutlined { get }
    var security: IconographyFill & IconographyOutlined { get }
    var profile: IconographyFill & IconographyOutlined { get }
    var securityProfile: IconographyFill & IconographyOutlined { get }
    var userCheck: IconographyFill & IconographyOutlined { get }
    var securityProfile2: IconographyFill & IconographyOutlined { get }
    var account: IconographyFill & IconographyOutlined { get }
    var pro: IconographyFill & IconographyOutlined { get }
    var group: IconographyFill & IconographyOutlined { get }
}
