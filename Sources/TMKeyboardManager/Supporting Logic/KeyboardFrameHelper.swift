//
//  File.swift
//  
//
//  Created by Raylee on 20.02.2022.
//

import UIKit

extension UIViewController {
    // MARK: - Private
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            var frame = self.view.frame
            frame.origin.y = -keyboardSize.height
            UIView.animate(withDuration: 0.12) {
                self.view.frame = frame
            }
        }
        (self as? TMKeyboardDelegate)?.keyboardWillShow?()
    }

    @objc func keyboardWillHide(notification: Notification) {
        var frame = self.view.frame
        frame.origin.y = 0
        UIView.animate(withDuration: 0.12) {
            self.view.frame = frame
        }
        (self as? TMKeyboardDelegate)?.keyboardWillHide?()
    }

    @objc func keyboardDidHide(notification: Notification) {
        (self as? TMKeyboardDelegate)?.keyboardDidHide?()
    }

    @objc func keyboardDidShow(notification: Notification) {
        (self as? TMKeyboardDelegate)?.keyboardDidShow?()
    }
}
