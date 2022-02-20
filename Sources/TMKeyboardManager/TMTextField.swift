//
//  TMTextField.swift
//  
//
//  Created by Konstantin Kolosov on 20.02.2022.
//

import UIKit

open class TMTextField: UITextField {
    
    /// add Date Picker for textField
    open func setDatePickerKeyboard(_ target: Any, selector: Selector,
                                      minDate: Date? = Date(),
                                      datePickerMode: UIDatePicker.Mode = .date,
                                      selectedDate: Date = Date()) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = datePickerMode
        datePicker.addTarget(target, action: selector, for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        if let minDate = minDate {
            datePicker.minimumDate = minDate
        }
        datePicker.date = selectedDate
        inputView = datePicker

        setToolbar()
    }

    /// Toolbar with Done and Next button
    open func setNextDoneToolbar(tintColor: UIColor = .systemBlue,
                                 nextTitle: String = "Next") {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(nextLogic))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [doneButton, flexibleSeparator, nextButton]
        toolbar.sizeToFit()
        toolbar.tintColor = tintColor
        inputAccessoryView = toolbar
    }

    /// Toolbar with Done button
    open func setDoneToolbar(tintColor: UIColor = .systemBlue) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [flexibleSeparator, doneButton]
        toolbar.sizeToFit()
        toolbar.tintColor = tintColor
        inputAccessoryView = toolbar
    }

    // MARK: - Private
    @objc private func doneLogic() {
        self.endEditing(false)
    }

    /// Check textFieldShouldReturn delegate and hide keyboard if necessary
    @objc open func nextLogic() {
        if self.delegate?.textFieldShouldReturn?(self) == false {
            self.endEditing(false)
        }
    }

    /// Arrange toolbar for dateTextField
    private func setToolbar(tintColor: UIColor = .systemBlue) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [flexibleSeparator, doneButton]
        toolbar.sizeToFit()
        toolbar.tintColor = tintColor
        inputAccessoryView = toolbar
    }
}
