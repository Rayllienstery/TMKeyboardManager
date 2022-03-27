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

#### Automatic frame for Controllers with keyboard functionality
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

#### Easiest access to the keyboard behaviour
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

#### Easy work with multiple InputFields

Inherit your UITextFielf with TMTextField

<img src= "https://raw.githubusercontent.com/Rayllienstery/TMKeyboardManager/main/Media/TMTextField.png" width="250" >

Use next functions to add toolbars
```swift
firstTextField.delegate = self
secondTextField.delegate = self
        
firstTextField.setNextDoneToolbar()
secondTextField.setDoneToolbar()
```

And provide shouldReturn Delegate function from UITextFieldDelegate
```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.focusOnNextPesponder(textField)
}
```

Full Implementation
```swift
import UIKit
import TMKeyboardManager

class DelegateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstTextField: TMTextField!
    @IBOutlet weak var secondTextField: TMTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.delegate = self
        secondTextField.delegate = self

        firstTextField.setNextDoneToolbar()
        secondTextField.setDoneToolbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initKeyboard()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deinitKeyboard()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.focusOnNextPesponder(textField)
    }
}
```

## License
<br />
Package released under the Apache 2.0 license, check the LICENSE file for more info.
