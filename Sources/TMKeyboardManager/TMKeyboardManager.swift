import UIKit

/// Follow this protocol, if you want receive keyboard status inside ViewController
///
/// Implemented function from protocol will be called when keyboard will posted show/hide notification to the NotificationCenter
/// Implement this even if you use initKeyboard() logic
@objc public protocol TMKeyboardProtocol {
    @objc optional func willShowKeyboard()
    @objc optional func willHideKeyboard()
}

/// If you want
public extension UIViewController {
    // MARK: - Public
    func initKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func deinitKeyboard() {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Private
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            var frame = self.view.frame
            frame.origin.y = -keyboardSize.height
            UIView.animate(withDuration: 0.12) {
                self.view.frame = frame
            }
        }
        (self as? TMKeyboardProtocol)?.willShowKeyboard?()
    }

    @objc private func keyboardWillHide(notification: Notification) {
        var frame = self.view.frame
        frame.origin.y = 0
        UIView.animate(withDuration: 0.12) {
            self.view.frame = frame
        }
        (self as? TMKeyboardProtocol)?.willHideKeyboard?()
    }
}
