//
//  TMTextField.swift
//  
//
//  Created by Konstantin Kolosov on 20.02.2022.
//

import UIKit

open class TMTextField: UITextField {
    private typealias Config = TMKeyboardConfig

    // MARK: - Open
    /// add Date Picker for textField
    open func setDatePickerKeyboard(_ target: Any, selector: Selector,
                                    minDate: Date? = nil,
                                    maxDate: Date? = nil,
                                    datePickerMode: UIDatePicker.Mode = .date,
                                    selectedDate: Date = Date()) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = datePickerMode
        datePicker.addTarget(target, action: selector, for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        datePicker.tintColor = Config.shared.tintColor

        if let minDate { datePicker.minimumDate = minDate }
        if let maxDate { datePicker.maximumDate = maxDate }

        datePicker.date = selectedDate
        inputView = datePicker

        setToolbar()
    }

    /// Call this for TextField and implement UIPickerViewDelegate, UIPickerDataSource as usual
    open func setPickerKeyboard(_ delegate: UIPickerViewDelegate) {
        let picker = UIPickerView()
        picker.dataSource = (delegate as? UIPickerViewDataSource)!
        picker.delegate = delegate
        picker.tintColor = Config.shared.tintColor
        inputView = picker
        setToolbar()
    }

    /// Toolbar with Done and Next button
    open func setNextDoneToolbar(nextTitle: String = "Next") {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(nextLogic))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [doneButton, flexibleSeparator, nextButton]
        toolbar.sizeToFit()
        toolbar.tintColor = Config.shared.tintColor
        inputAccessoryView = toolbar
    }

    /// Toolbar with Done button
    open func setDoneToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [flexibleSeparator, doneButton]
        toolbar.sizeToFit()
        toolbar.tintColor = Config.shared.tintColor
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
    private func setToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneLogic))
        toolbar.items = [flexibleSeparator, doneButton]
        toolbar.sizeToFit()
        toolbar.tintColor = Config.shared.tintColor
        inputAccessoryView = toolbar
    }
}
