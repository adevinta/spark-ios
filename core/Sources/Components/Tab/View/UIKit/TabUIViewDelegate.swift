//
//  TabUIViewDelegate.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol TabUIViewDelegate: AnyObject {
    func segmentSelected(index: Int, sender: TabUIView) 
}
