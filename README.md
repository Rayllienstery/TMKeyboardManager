# TMKeyboardManager
<br />

## Features

- [x] Automatic frame for Controllers with keyboard functionality
- [x] Easiest access to the keyboard behaviour 
- [x] Autohide keyboard on background tap
- [x] Easy work with multiple InputFields
- [x] UIPicker/UIDatePicker as keyboard
- [x] Done and Next+Done toolbar for keyboard 

## Requirements

- iOS 14.0+
- Xcode 13

## Installation

### Swift Package Manager

Instructions for [Swift Package Manager](https://swift.org/package-manager/) support can be
found at [SwiftPackageManager](SwiftPackageManager.md) Markdown file.

## Usage example

Automatic frame for Controllers with keyboard functionality
```swift
import UIKit
import TMKeyboardManager

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initKeyboard()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deinitKeyboard()
    }
}
```

Easiest access to the keyboard behaviour
```swift
import UIKit
import TMKeyboardManager

class ViewController: UIViewController, TMKeyboardDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initKeyboard()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deinitKeyboard()
    }

    // MARK: - TMKeyboardDelegate
    func keyboardWillShow() {
        print("keyboardWillShow")
    }

    func keyboardWillHide() {
        print("keyboardWillHide")
    }

    func keyboardDidShow() {
        print("keyboardDidShow")
    }

    func keyboardDidHide() {
        print("keyboardDidHide")
    }
}
```
