//
//  IconographyUserDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyUserDefault: IconographyUser {

    // MARK: - Properties

    public let verified: IconographyFill & IconographyOutlined
    public let warningSecurity: IconographyFill & IconographyOutlined
    public let security: IconographyFill & IconographyOutlined
    public let profile: IconographyFill & IconographyOutlined
    public let securityProfile: IconographyFill & IconographyOutlined
    public let userCheck: IconographyFill & IconographyOutlined
    public let securityProfile2: IconographyFill & IconographyOutlined
    public let account: IconographyFill & IconographyOutlined
    public let pro: IconographyFill & IconographyOutlined
    public let group: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(verified: IconographyFill & IconographyOutlined,
                warningSecurity: IconographyFill & IconographyOutlined,
                security: IconographyFill & IconographyOutlined,
                profile: IconographyFill & IconographyOutlined,
                securityProfile: IconographyFill & IconographyOutlined,
                userCheck: IconographyFill & IconographyOutlined,
                securityProfile2: IconographyFill & IconographyOutlined,
                account: IconographyFill & IconographyOutlined,
                pro: IconographyFill & IconographyOutlined,
                group: IconographyFill & IconographyOutlined) {
        self.verified = verified
        self.warningSecurity = warningSecurity
        self.security = security
        self.profile = profile
        self.securityProfile = securityProfile
        self.userCheck = userCheck
        self.securityProfile2 = securityProfile2
        self.account = account
        self.pro = pro
        self.group = group
    }
}
