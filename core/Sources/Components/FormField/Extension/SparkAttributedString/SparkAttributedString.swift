//
//  SparkAttributedString.swift
//  SparkCore
//
//  Created by alican.aycil on 02.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

protocol SparkAttributedString {}
extension NSAttributedString: SparkAttributedString {}
extension AttributedString: SparkAttributedString {}
