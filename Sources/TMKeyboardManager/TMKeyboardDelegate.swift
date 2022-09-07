//
//  File.swift
//  
//
//  Created by Konstantin Kolosov on 08.09.2022.
//

import Foundation

/// Follow this protocol, if you want receive keyboard status inside ViewController
/// Implemented function from protocol will be called when keyboard will posted show/hide notification to the NotificationCenter
/// Implement this even if you use initKeyboard() logic
@objc public protocol TMKeyboardDelegate {
    @objc optional func keyboardWillShow()
    @objc optional func keyboardWillHide()

    @objc optional func keyboardDidShow()
    @objc optional func keyboardDidHide()
}
