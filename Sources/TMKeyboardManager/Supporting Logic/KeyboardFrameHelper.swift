//
//  File.swift
//  
//
//  Created by Raylee on 20.02.2022.
//

import UIKit

typealias BottomView = UIView

extension UIViewController {

    // MARK: - Delegate
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async { [self] in
            if let inputView = view.firstResponder,
               let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                                        as? NSValue)?.cgRectValue {
                let viewFrame = view.convert(inputView.frame, from: inputView.superview)
                // TODO: - Remove debug
                inputView.backgroundColor = .systemGreen.withAlphaComponent(0.2)

                if keyboardFrame.minY < viewFrame.maxY {
                    var frame = view.frame

                    let window = UIApplication.shared.windows.first
                    let bottomPadding = window?.safeAreaInsets.bottom

                    let bottomSpaceForFullScreen = (bottomPadding ?? .zero) + 16
                    let bottomSpaceForModal: CGFloat = (bottomPadding ?? .zero) + 84
                    let bottomSpace: CGFloat = self.modalPresentationStyle.rawValue == 0
                        ? bottomSpaceForFullScreen : bottomSpaceForModal
                    let keyboardHeight = keyboardFrame.height + 16

                    let newY = -((viewFrame.maxY) - keyboardFrame.minY) - (bottomSpace)

                    frame.origin.y = newY > -keyboardHeight ? newY : -keyboardHeight
//                    frame.origin.y = -keyboardFrame.height
//                    frame.origin.y = -inputView.frame.height
                    UIView.animate(withDuration: 0.24) {
                        self.view.frame = frame
                        self.view.layoutIfNeeded()
                    }
                    print(newY)
                    print(-keyboardHeight)
                    print(frame)
                }
            }
        }
        (self as? TMKeyboardDelegate)?.keyboardWillShow()
    }

    @objc func keyboardWillHide(notification: Notification) {
        var frame = self.view.frame
        frame.origin.y = 0
        UIView.animate(withDuration: 0.12) {
            self.view.frame = frame
        }
        (self as? TMKeyboardDelegate)?.keyboardWillHide()
    }

    @objc func keyboardDidHide(notification: Notification) {
        (self as? TMKeyboardDelegate)?.keyboardDidHide()
    }

    @objc func keyboardDidShow(notification: Notification) {
        (self as? TMKeyboardDelegate)?.keyboardDidShow()
    }
}
