//
//  Suger.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import Foundation
import UIKit

protocol Sugar { }
// MARK: - 语法糖
extension Sugar where Self : Any {
    // 所有类型都可以用
    @discardableResult
    func with(_ block: (inout Self) -> Void) -> Self{
        var copy = self
        block(&copy)
        return copy
    }
    
    // 只能对引用类型使用
    @discardableResult
    func then(_ block: (Self) -> Void) -> Self{
        block(self)
        return self
    }
}

extension NSObject: Sugar {}
