//
//  UIView+format.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

extension UIView {
    func transforToCircle() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
