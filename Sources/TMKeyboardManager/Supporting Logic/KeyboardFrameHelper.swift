//
//  File.swift
//  
//
//  Created by Raylee on 20.02.2022.
//

import UIKit

typealias BottomView = UIView

extension UIViewController {
    func addBottomView() {
        if view.subviews.filter({type(of: $0) == BottomView.self}).count == 0 {
            let bottomView = BottomView(
                frame: .init(
                    origin: .init(x: 0, y: view.frame.size.height - 200),
                    size: .init(width: view.frame.width, height: view.frame.height / 2)))
            bottomView.backgroundColor = view.backgroundColor
            view.addSubview(bottomView)
            view.sendSubviewToBack(bottomView)
        }
    }

    // MARK: - Delegate
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async { [self] in
            if let inputView = view.firstResponder?.superview,
               let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                                        as? NSValue)?.cgRectValue {
                let viewFrame = view.convert(inputView.frame, from: inputView.superview)
                if keyboardFrame.minY < viewFrame.maxY {
                    var frame = view.frame
                    frame.origin.y = -((viewFrame.maxY) - keyboardFrame.minY) - 80
                    UIView.animate(withDuration: 0.24) {
                        self.view.frame = frame
                        self.view.layoutIfNeeded()
                    }
                }
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
