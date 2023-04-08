//
//  File.swift
//  
//
//  Created by Raylee on 20.02.2022.
//

import UIKit

typealias BottomView = UIView

extension UIViewController {
    private var isModal: Bool {
        let isPresentingViewController = presentingViewController != nil
        let isNavigationController = navigationController?.presentingViewController?.presentedViewController == navigationController
        let isUITabBarController = tabBarController?.presentingViewController is UITabBarController

        return isPresentingViewController || isNavigationController || isUITabBarController
    }

    // MARK: - Delegate
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async { [self] in
            if let inputView = view.firstResponder,
               let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                                        as? NSValue)?.cgRectValue {
                let viewFrame = view.convert(inputView.frame, from: inputView.superview)
                let frameSpacer = UIScreen.main.bounds.height - view.frame.height //+ viewFrame.height

                if (keyboardFrame.minY - frameSpacer) < viewFrame.maxY {
                    var frame = view.frame
                    let bottomPadding: CGFloat = 16

                    let keyboardPadding = -(keyboardFrame.height + bottomPadding)

                    let newY = -((viewFrame.maxY) - keyboardFrame.minY) - bottomPadding
                    let verticalOvermoved = newY < keyboardPadding

                    frame.origin.y = (verticalOvermoved ? keyboardPadding : newY) - frameSpacer
                    UIView.animate(withDuration: 0.24) {
                        self.view.frame = frame
                        self.view.layoutIfNeeded()
                    }

                    print("\n=====\nframeSpacer", frameSpacer)
                    print("verticalOvermoved", verticalOvermoved)
                    print("viewFrame.height", viewFrame.height)
                    print("viewFrame.maxY", viewFrame.maxY)
                    print("keyboardFrame.minY", keyboardFrame.minY)
                    print("newY", newY)
                    print("keyboardPadding", keyboardPadding)
                    print(frame.origin.y)
                    print("=====")
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
