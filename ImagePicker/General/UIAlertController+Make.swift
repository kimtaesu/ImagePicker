//
//  UIAlertController+Make.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

public struct UIAlertActionModel: ExpressibleByStringLiteral {
    let title: String
    let closure: ((UIAlertAction) -> Void)?

    public init(_ title: String, _ closure: ((UIAlertAction) -> Void)? = nil) {
        self.title = title
        self.closure = closure
    }
    public init(stringLiteral value: String) {
        self.title = value
        self.closure = nil
    }
}

public extension UIAlertController {
    static func make(
        title: String? = nil,
        message: String,
        ok: UIAlertActionModel? = nil,
        cancel: UIAlertActionModel? = nil,
        style: UIAlertController.Style = .alert
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        var localOk = ok
        if localOk == nil && cancel == nil {
            localOk = UIAlertActionModel("확인")
        }

        if let localOk = localOk {
            alert.addAction(UIAlertAction(title: localOk.title, style: .default, handler: localOk.closure))
        }

        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel.title, style: .cancel, handler: cancel.closure))
        }

        return alert
    }

    func alertShow(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: true, completion: completion)
    }
    
    static func makeSheet(title: String? = nil,
                     message: String,
                     style: UIAlertController.Style = .actionSheet,
                     sheet: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for value in sheet {
            alert.addAction(value)
        }
        
        if sheet.isEmpty {
            alert.addAction(UIAlertAction(title: "확인", style: .default))
        }
        return alert
    }

}
