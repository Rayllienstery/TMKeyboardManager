//
//  TMTextView.swift
//  
//
//  Created by Konstantin Kolosov on 18.06.2022.
//

import UIKit

open class TMTextView: UITextView {
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
        inputView = picker
        setToolbar()
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
