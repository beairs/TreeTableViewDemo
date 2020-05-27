//
//  Extension.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    class func creat(font: UIFont?, color: UIColor = .black) -> UILabel {
        return UILabel().then({ (l) in
            l.font = font
            l.textColor = color
        })
    }
}

extension UIFont {
    // 常规
    class func pingFangRegular(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "PingFangSC-Regular", size: size)
    }
    // 中
    class func pingFangMedium(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "PingFangSC-Medium", size: size)
    }
    // 粗
    class func pingFangSemibold(size: CGFloat) -> UIFont? {
        return UIFont.init(name: "PingFangSC-Semibold", size: size)
    }
    
    class var PingFang_Bold22: UIFont? { return UIFont.init(name: "PingFangSC-Semibold", size: 22) }
    
    class var PingFang_Bold20: UIFont? { return UIFont.init(name: "PingFangSC-Semibold", size: 20) }
    class var PingFang_Bold18: UIFont? { return UIFont.init(name: "PingFangSC-Semibold", size: 18) }
    class var PingFang_Medium17: UIFont? { return UIFont.init(name: "PingFangSC-Medium", size: 17) }
    class var PingFang_Medium16: UIFont? { return UIFont.init(name: "PingFangSC-Medium", size: 16) }
    class var PingFang_Regular16: UIFont? { return UIFont.init(name: "PingFangSC-Regular", size: 16) }
    class var PingFang_Regular14: UIFont? { return UIFont.init(name: "PingFangSC-Regular", size: 14) }
    class var PingFang_Regular12: UIFont? { return UIFont.init(name: "PingFangSC-Regular", size: 12) }
}


extension UIColor {
    class var nblack: UIColor { return hexColor("191D21")}
    class var ngray: UIColor { return hexColor("999BA1") }
    class var icon: UIColor { return hexColor("e5e5e5") }
    
    class func hexColor(_ string: String, alpha: CGFloat = 1.0) -> UIColor {
        
        guard (string.count == 7 && string.hasPrefix("#")) || string.count == 6 else {
            return .clear
        }
        
        var colorString = string.lowercased()
        
        if (colorString.count == 7 && colorString.hasPrefix("#")) {
            colorString = String(colorString[colorString.index(after: colorString.startIndex) ..< colorString.endIndex])
        }
        
        let dictionary: [Character: CGFloat] = [
            "0": 0,
            "1": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "a": 10,
            "b": 11,
            "c": 12,
            "d": 13,
            "e": 14,
            "f": 15
        ]
        
        var value: CGFloat = 0
        var array = [CGFloat]()
        
        for (i, c) in colorString.enumerated(){
            
            let v: CGFloat = dictionary[c] ?? 0
            
            if i % 2 == 0 {
                
                value += v*16
                
            } else {
                value += v
                array.append(value)
                value = 0
            }
            
        }
        
        return UIColor.init(red: array[0] / 255.0,
                            green: array[1] / 255.0,
                            blue: array[2] / 255.0,
                            alpha: alpha)
    }
}


extension Array {
    func forEachHandle(handle: ((Int, Bool, Element)->Void)) {
        guard count > 0 else { return }
        for i in 0 ..< count {
            handle(i, i == count - 1, self[i])
        }
    }
}
