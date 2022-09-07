import UIKit

/// The main purpose of the library is to automate and minimize interaction with the elements that call the keyboard.
/// initKeyboard() adds two observers to the NotificationCenter that monitor the state of the keyboard and then, if necessary, change the position of view.frame so that the input field is always visible
/// Use it on the ViewDidAppear()
///
/// deinitKeyboard(): Do not forget that NotificationCenter puts a load on RAM, does not allow you to release resources, and therefore do not forget to release unnecessary observers, to make this, call deinitKeyboard() on viewDidDissapear()
public extension UIViewController {
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
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

    @objc func endEditing() {
        view.endEditing(true)
    }
}
