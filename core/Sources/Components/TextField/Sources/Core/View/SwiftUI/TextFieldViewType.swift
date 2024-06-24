//
//  TextFieldViewType.swift
//  SparkCore
//
//  Created by louis.borlee on 02/04/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

/// A TextField type with its associated callback(s)
public enum TextFieldViewType {
    case secure(onCommit: () -> Void = {})
    case standard(onEditingChanged: (Bool) -> Void = { _ in }, onCommit: () -> Void = {})
}
