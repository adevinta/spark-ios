//
//  NSAttributedStringBuilder.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 25.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

final class NSAttributedStringBuilder {
    private var nsAttributedString = NSMutableAttributedString()

    func text(_ label: String) -> Self {
        self.nsAttributedString.append(NSAttributedString(string: label))
        return self
    }

    func text(_ label: String, color: UIColor) -> Self {
        let attributedStringColor = [NSAttributedString.Key.foregroundColor: color];
        self.nsAttributedString.append(NSAttributedString(string: label, attributes: attributedStringColor))
        return self
    }

    func symbol(_ imageName: String) -> Self {
        guard let image = UIImage(systemName: imageName) else { return self }
        let imageAttachment = NSTextAttachment(image: image)
        let imageString = NSAttributedString(attachment: imageAttachment)
        self.nsAttributedString.append(imageString)
        return self
    }

    func superscript(_ text: String) -> Self {
        let superscript = NSAttributedString(
            string: text,
            attributes: [
                .baselineOffset: 8,
                .font: UIFont.systemFont(ofSize: 8)
            ]
        )

        self.nsAttributedString.append(superscript)
        return self
    }

    func build() -> NSAttributedString {
        return nsAttributedString
    }
}
