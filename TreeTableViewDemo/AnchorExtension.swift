//
//  AnchorExtension.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import Foundation
import UIKit

enum AnchorMode {
    case equal
    case less
    case greater
}

func makeXAnchor(from: NSLayoutXAxisAnchor, to: NSLayoutXAxisAnchor, constant: CGFloat, mode: AnchorMode) -> NSLayoutConstraint {
    var cons: NSLayoutConstraint!
    switch mode {
    case .equal: cons = from.constraint(equalTo: to, constant: constant)
    case .less: cons = from.constraint(lessThanOrEqualTo: to, constant: constant)
    case .greater: cons = from.constraint(greaterThanOrEqualTo: to, constant: constant)
    }
    cons.isActive = true
    return cons
}

func makeYAnchor(from: NSLayoutYAxisAnchor, to: NSLayoutYAxisAnchor, constant: CGFloat, mode: AnchorMode) -> NSLayoutConstraint {
    var cons: NSLayoutConstraint!
    switch mode {
    case .equal: cons = from.constraint(equalTo: to, constant: constant)
    case .less: cons = from.constraint(lessThanOrEqualTo: to, constant: constant)
    case .greater: cons = from.constraint(greaterThanOrEqualTo: to, constant: constant)
    }
    cons.isActive = true
    return cons
}

func makeSizeAnchor(from: NSLayoutDimension, to: NSLayoutDimension, constant: CGFloat, mode: AnchorMode) -> NSLayoutConstraint {
    
    var cons: NSLayoutConstraint!
    switch mode {
    case .equal: cons = from.constraint(equalTo: to, constant: constant)
    case .less: cons = from.constraint(lessThanOrEqualTo: to, constant: constant)
    case .greater: cons = from.constraint(greaterThanOrEqualTo: to, constant: constant)
    }
    cons.isActive = true
    return cons
}

extension UIView {
    
    func activeAutoLayout(subViews: [UIView]) {
        subViews.forEach { [weak self] (v) in
            guard let weakSelf = self else {return}
            v.activeAutoLayout(addtoView: weakSelf)
        }
    }
    
    @discardableResult
    func activeAutoLayout(addtoView superView: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func leadingAnchor(to other: NSLayoutXAxisAnchor, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeXAnchor(from: leadingAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func leadingAnchor(to other: UIView, constant: CGFloat = 0, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeXAnchor(from: leadingAnchor, to: other.leadingAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func trailingAnchor(to other: NSLayoutXAxisAnchor, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeXAnchor(from: trailingAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func trailingAnchor(to other: UIView, constant: CGFloat = 0, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeXAnchor(from: trailingAnchor, to: other.trailingAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func topAnchor(to other: NSLayoutYAxisAnchor, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: topAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func topAnchor(to other: UIView, constant: CGFloat = 0, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: topAnchor, to: other.topAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func bottomAnchor(to other: NSLayoutYAxisAnchor, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: bottomAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func bottomAnchor(to other: UIView, constant: CGFloat = 0, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: bottomAnchor, to: other.bottomAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func lastBaseline(to other: NSLayoutYAxisAnchor, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: lastBaselineAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func lastBaseline(to other: UIView, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeYAnchor(from: lastBaselineAnchor, to: other.lastBaselineAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func widthAnchor(to other: NSLayoutDimension, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeSizeAnchor(from: widthAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func widthAnchor(to other: UIView, constant: CGFloat = 0, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeSizeAnchor(from: widthAnchor, to: other.widthAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func widthAnchor(_ constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        var cons: NSLayoutConstraint!
        switch mode {
        case .equal: cons = widthAnchor.constraint(equalToConstant: constant)
        case .less: cons = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        case .greater: cons = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        }
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func heightAnchor(to other: NSLayoutDimension, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeSizeAnchor(from: heightAnchor, to: other, constant: constant, mode: mode)
    }
    
    @discardableResult
    func heightAnchor(to other: UIView, constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        return makeSizeAnchor(from: heightAnchor, to: other.heightAnchor, constant: constant, mode: mode)
    }
    
    @discardableResult
    func heightAnchor(_ constant: CGFloat, mode: AnchorMode = .equal) -> NSLayoutConstraint {
        var cons: NSLayoutConstraint!
        switch mode {
        case .equal: cons = heightAnchor.constraint(equalToConstant: constant)
        case .less: cons = heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        case .greater: cons = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        }
        
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topToBottom(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor(to: other.bottomAnchor, constant: constant)
    }
    
    @discardableResult
    func topToLastBaseline(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor(to: other.lastBaselineAnchor, constant: constant)
    }
    
    @discardableResult
    func bottomToTop(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return bottomAnchor(to: other.topAnchor, constant: constant)
    }
    
    @discardableResult
    func lastBaselineToTop(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return lastBaseline(to: other.topAnchor, constant: constant)
    }
    
    @discardableResult
    func leadingToTrailing(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return leadingAnchor(to: other.trailingAnchor, constant: constant)
    }
    
    @discardableResult
    func trailingToLeading(other: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return trailingAnchor(to: other.leadingAnchor, constant: constant)
    }
    
    @discardableResult
    func leadingAnchor(_ constant: CGFloat = 0) -> Self {
        leadingAnchor(to: superview!, constant: constant)
        return self
    }
    
    @discardableResult
    func trailingAnchor(_ constant: CGFloat = 0) -> Self {
        trailingAnchor(to: superview!, constant: constant)
        return self
    }
    @discardableResult
    func topAnchor(_ constant: CGFloat = 0) -> Self {
        topAnchor(to: superview!, constant: constant)
        return self
    }
    @discardableResult
    func bottomAnchor(_ constant: CGFloat = 0) -> Self {
        bottomAnchor(to: superview!, constant: constant)
        return self
    }
    
    func coverOnSuperView() {
        leadingAnchor().topAnchor().trailingAnchor().bottomAnchor()
    }
    
    func leading_trailing(_ constant: CGFloat) {
        leadingAnchor(constant).trailingAnchor(-constant)
    }
    
    func leading_trailing(to view: UIView) {
        leadingAnchor(to: view)
        trailingAnchor(to: view)
    }
    
    func top_bottom(_ constant: CGFloat) {
        topAnchor(constant).bottomAnchor(-constant)
    }
    
    func top_bottom(to view: UIView){
        topAnchor(to: view)
        bottomAnchor(to: view)
    }
    
    func width_heightAnchorEqualToFrame() {
        widthAnchor(frame.size.width)
        heightAnchor(frame.size.height)
    }
    
    @discardableResult
    func centerXAnchor(to view: UIView) -> NSLayoutConstraint {
        let cons = centerXAnchor.constraint(equalTo: view.centerXAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func centerYAnchor(to view: UIView) -> NSLayoutConstraint {
        let cons = centerYAnchor.constraint(equalTo: view.centerYAnchor)
        cons.isActive = true
        return cons
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func offSet(_ constant: CGFloat) -> NSLayoutConstraint {
        self.constant = constant
        return self
    }
}
