import UIKit

/// Follow this protocol, if you want receive keyboard status inside ViewController
///
/// Implemented function from protocol will be called when keyboard will posted show/hide notification to the NotificationCenter
/// Implement this even if you use initKeyboard() logic
@objc public protocol TMKeyboardProtocol {
    @objc optional func willShowKeyboard()
    @objc optional func willHideKeyboard()
}

/// The main purpose of the library is to automate and minimize interaction with the elements that call the keyboard.
/// initKeyboard() adds two observers to the NotificationCenter that monitor the state of the keyboard and then, if necessary, change the position of view.frame so that the input field is always visible
/// Use it on the ViewDidAppear()
///
/// deinitKeyboard(): Do not forget that NotificationCenter puts a load on RAM, does not allow you to release resources, and therefore do not forget to release unnecessary observers, to make this, call deinitKeyboard() on viewDidDissapear()
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
