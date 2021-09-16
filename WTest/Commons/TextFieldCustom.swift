//
//  TextFieldCustom.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

class TextFieldCustom: UITextField {
    
    init(_ placeHolder: String? = nil, _ delegate: UITextFieldDelegate? = nil) {
        super.init(frame: .zero)
        placeholder = placeHolder ?? ""
        borderStyle = .roundedRect
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 8
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
