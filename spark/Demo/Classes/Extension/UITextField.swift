//
//  UITextField.swift
//  SparkDemo
//
//  Created by alican.aycil on 18.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UITextField {

    func addDoneButtonOnKeyboard() {

       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()

       let flexibleSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
       )
       let doneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(resignFirstResponder)
       )
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
   }
}
