//
//  File.swift
//  
//
//  Created by Konstantin Kolosov on 30.12.2022.
//

import UIKit

public final class TMKeyboardConfig {
    public static let shared = TMKeyboardConfig.init()

    public var tintColor: UIColor = .systemBlue

    private init() { }
}
