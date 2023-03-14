//
//  IconographyUserDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyUserDefault: IconographyUser {

    // MARK: - Properties

    public let verified: IconographyFilled & IconographyOutlined
    public let warningSecurity: IconographyFilled & IconographyOutlined
    public let security: IconographyFilled & IconographyOutlined
    public let profile: IconographyFilled & IconographyOutlined
    public let securityProfile: IconographyFilled & IconographyOutlined
    public let userCheck: IconographyFilled & IconographyOutlined
    public let securityProfile2: IconographyFilled & IconographyOutlined
    public let account: IconographyFilled & IconographyOutlined
    public let pro: IconographyFilled & IconographyOutlined
    public let group: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(verified: IconographyFilled & IconographyOutlined,
                warningSecurity: IconographyFilled & IconographyOutlined,
                security: IconographyFilled & IconographyOutlined,
                profile: IconographyFilled & IconographyOutlined,
                securityProfile: IconographyFilled & IconographyOutlined,
                userCheck: IconographyFilled & IconographyOutlined,
                securityProfile2: IconographyFilled & IconographyOutlined,
                account: IconographyFilled & IconographyOutlined,
                pro: IconographyFilled & IconographyOutlined,
                group: IconographyFilled & IconographyOutlined) {
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
