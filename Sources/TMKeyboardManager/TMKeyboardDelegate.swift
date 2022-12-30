//
//  File.swift
//  
//
//  Created by Konstantin Kolosov on 08.09.2022.
//

import UIKit

public protocol TMKeyboardDelegate: UIViewController {
    func initKeyboard()
    func initKeyboardObserver()
    func initHideKeyboardGesture()
    func deinitKeyboard()

    /// Implemented function from protocol will be called when keyboard will posted show/hide notification to the NotificationCenter
    /// Implement this even if you use initKeyboard() logic
    func keyboardWillShow()
    func keyboardWillHide()

    func keyboardDidShow()
    func keyboardDidHide()
}

public extension TMKeyboardDelegate {
    // MARK: - Public
    func initKeyboard() {
        initKeyboardObserver()
        initHideKeyboardGesture()
        addBottomView()
    }

    func initKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    func initHideKeyboardGesture() {
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
//        let gesture = UITapGestureRecognizer(target: self, action: Selector { debugPrint("my code here") })
        let gesture = ClosureTapGestureRecognizer { [weak self] in
            self?.endEditing()
        }
        view.addGestureRecognizer(gesture)
    }

    func deinitKeyboard() {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    

    func keyboardWillShow() { }
    func keyboardWillHide() { }

    func keyboardDidShow() { }
    func keyboardDidHide() { }

    // MARK: - Private
    private func endEditing() {
        view.endEditing(true)
    }

    /// Check view and find textView with next tag, then focus on it
    func focusOnNextPesponder(_ textField: UITextField) -> Bool {
        let targetTag = textField.tag + 1

        if let nextResponder = view.viewWithTag(targetTag) as? UITextField {
            nextResponder.becomeFirstResponder()
            return true
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

private class ClosureTapGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}
