import UIKit

/// The main purpose of the library is to automate and minimize interaction with the elements that call the keyboard.
/// initKeyboard() adds two observers to the NotificationCenter that monitor the state of the keyboard and then, if necessary, change the position of view.frame so that the input field is always visible
/// Use it on the ViewDidAppear()
///
/// deinitKeyboard(): Do not forget that NotificationCenter puts a load on RAM, does not allow you to release resources, and therefore do not forget to release unnecessary observers, to make this, call deinitKeyboard() on viewDidDissapear()
public extension UIViewController {

}
