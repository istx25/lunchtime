//
//  UIAlertController+Extras.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-17.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit

public extension UIAlertController {

    // MARK: - Convenience Initialiser
    convenience init(title: String? = nil, preferredStyle: UIAlertControllerStyle) {
        self.init(title: title, message: nil, preferredStyle: preferredStyle)
    }

    static func controller(title: String? = nil, preferredStyle: UIAlertControllerStyle) -> UIAlertController {
        return UIAlertController(title: title, preferredStyle: preferredStyle);
    }

    // MARK: - Convenience Actions
    func addAction(title title: String, style: UIAlertActionStyle, handler: (() -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: style, handler: { _ in handler?() }))
    }

    func addDestructiveAction(title title: String, handler: (() -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: .Destructive, handler: { _ in handler?() }))
    }

    func addDefaultAction(title title: String, handler: (() -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: .Default, handler: { _ in handler?() }))
    }

    func addCancelAction(title: String = "Cancel", handler: (() -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: .Cancel, handler: { _ in handler?() }))
    }
}