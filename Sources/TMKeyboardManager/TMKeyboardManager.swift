import UIKit

@objc protocol TMKeyboardProtocol {
    @objc optional func didShowKeyboard()
    @objc optional func didHideKeyboard()
}

public extension UIViewController {

    func initKeyboardObserver() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func deinitKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            var frame = self.view.frame
            frame.origin.y = -keyboardSize.height
            UIView.animate(withDuration: 0.12) {
                self.view.frame = frame
            }
        }
        (self as? TMKeyboardProtocol)?.didShowKeyboard?()
    }

    @objc func keyboardWillHide(notification: Notification) {
        var frame = self.view.frame
        frame.origin.y = 0
        UIView.animate(withDuration: 0.12) {
            self.view.frame = frame
        }
        (self as? TMKeyboardProtocol)?.didHideKeyboard?()
    }
}
