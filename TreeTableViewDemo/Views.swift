//
//  Views.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import Foundation
import UIKit
// MARK: - 组织列表Cell (新)
class AddressBookParentCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel.creat(font: UIFont.pingFangSemibold(size: 17), color: .nblack)
    
    let arrowBtn = UIButton()
    
    private var lineViews = [UIView]()
    private var titleLeadingCons: NSLayoutConstraint?
    
    private let lineMargin: CGFloat = 23
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.activeAutoLayout(subViews: [arrowBtn, titleLabel])
        
        arrowBtn.then { (i) in
            titleLeadingCons = i.leadingAnchor(to: contentView.leadingAnchor, constant: 14)
            i.centerYAnchor(to: titleLabel)
            i.setImage(UIImage.init(named: "展开"), for: .normal)
            i.setImage(UIImage.init(named: "收起"), for: .selected)
            i.backgroundColor = .white
            i.isUserInteractionEnabled = false
        }
        
        titleLabel.then { (i) in
            i.leadingToTrailing(other: arrowBtn, constant: 8)
            i.topAnchor(9)
            i.bottomAnchor(-6)
        }
    }
    
    func updateUI(model: CompanyDepartmentModel) {
        titleLabel.text = model.DeptName
        arrowBtn.isSelected = model.isExpand
        
        var leadingMargin: CGFloat = 14
        if model.depth > 0 {
            leadingMargin = lineMargin * (CGFloat(model.depth) + 1) - 9
        }
        
        lineViews.forEach { (v) in
            v.removeFromSuperview()
        }
        
        lineViews = []
        
        if model.depth > 0 {
            for index in 0 ... model.depth {
                if index == model.depth
                { // model 深度绘制线
                    // 竖线
                    if model.isExpand && model.nodes.count > 0 {
                        lineViews.append(UIView().then({ (i) in
                            i.translatesAutoresizingMaskIntoConstraints = false
                            contentView.insertSubview(i, belowSubview: arrowBtn)
                            i.widthAnchor(1)
                            i.backgroundColor = .icon
                            i.topAnchor.constraint(equalTo: arrowBtn.centerYAnchor).isActive = true
                            i.bottomAnchor(0)
                            i.leadingAnchor(lineMargin * CGFloat(index + 1))
                        }))
                    }
                    // 横线
                    lineViews.append(UIView().then({ (i) in
                        i.translatesAutoresizingMaskIntoConstraints = false
                        contentView.insertSubview(i, belowSubview: arrowBtn)
                        i.heightAnchor(1)
                        i.backgroundColor = .icon
                        i.trailingAnchor.constraint(equalTo: arrowBtn.centerXAnchor).isActive = true
                        i.widthAnchor(23)
                        i.centerYAnchor(to: arrowBtn)
                    }))
                }
                else
                { // model 之前深度绘制线
                    // 竖线
                    if model.dontShowLineSet.contains(index) == false {
                        lineViews.append(UIView().then({ (i) in
                            i.translatesAutoresizingMaskIntoConstraints = false
                            contentView.insertSubview(i, belowSubview: arrowBtn)
                            i.widthAnchor(1)
                            i.backgroundColor = .icon

                            if model.isLast && index == model.depth - 1 {
                                i.topAnchor()
                                i.bottomAnchor(to: arrowBtn.centerYAnchor, constant: 0).isActive = true
                            } else {
                                i.top_bottom(0)
                            }
                            
                            i.leadingAnchor(lineMargin * CGFloat(index + 1))
                        }))
                    }
                }
            }
        } else {
            // 首个深度的竖线
            if model.isExpand {
                lineViews.append(UIView().then({ (i) in
                    i.translatesAutoresizingMaskIntoConstraints = false
                    contentView.insertSubview(i, belowSubview: arrowBtn)
                    i.widthAnchor(1)
                    i.backgroundColor = .icon
                    i.topAnchor.constraint(equalTo: arrowBtn.centerYAnchor).isActive = true
                    i.bottomAnchor(0)
                    i.leadingAnchor(lineMargin)
                }))
            }
        }
        
        titleLeadingCons?.constant = leadingMargin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddressBookChildCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel.creat(font: UIFont.PingFang_Regular16, color: .nblack)
    
    let remarkLabel = UILabel.creat(font: UIFont.PingFang_Regular14, color: .ngray)
    
    let phoneBtn = UIButton()
    
    let chatBtn = UIButton()
    
    private var lineViews = [UIView]()
    private var titleLeadingCons: NSLayoutConstraint?
    private let lineMargin: CGFloat = 23
    
    weak var model: DepartmentContactUser?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.activeAutoLayout(subViews: [titleLabel,remarkLabel, phoneBtn, chatBtn])
        
        chatBtn.then { (i) in
            i.trailingAnchor(-13)
            i.topAnchor(2)
            i.setImage(UIImage.init(named: "消息"), for: .normal)
            i.addTarget(self, action: #selector(chat), for: .touchUpInside)
            i.sizeToFit()
            i.width_heightAnchorEqualToFrame()
        }
        
        phoneBtn.then { (i) in
            i.trailingToLeading(other: chatBtn, constant: -8)
            i.centerYAnchor(to: chatBtn)
            i.setImage(UIImage.init(named: "电话可拨打"), for: .normal)
            i.setImage(UIImage.init(named: "电话未可拨打"), for: .disabled)
            i.addTarget(self, action: #selector(phoneCall), for: .touchUpInside)
            i.sizeToFit()
            i.width_heightAnchorEqualToFrame()
        }
        
        titleLabel.then { (i) in
            titleLeadingCons = i.leadingAnchor(to: contentView.leadingAnchor, constant: 14)
            i.centerYAnchor(to: chatBtn)
            i.trailingToLeading(other: phoneBtn, constant: -8)
            i.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            i.setContentHuggingPriority(.defaultLow, for: .horizontal)
            i.backgroundColor = .white
        }
        
        remarkLabel.then { (i) in
            i.leadingAnchor(to: titleLabel)
            i.trailingAnchor(to: chatBtn)
            i.numberOfLines = 0
            i.bottomAnchor(-6)
            i.topToBottom(other: chatBtn, constant: 4)
        }
    }
    
    func updateUI(model: DepartmentContactUser) {
        self.model = model
        titleLabel.text = model.RealName
        remarkLabel.text = model.Remarks
        phoneBtn.isEnabled = model.IsCanCall
        
        var leadingMargin: CGFloat = 14
        if model.depth > 0 {
            leadingMargin = lineMargin * (CGFloat(model.depth) + 1) - 9
        }
        
        lineViews.forEach { (v) in
            v.removeFromSuperview()
        }
        
        lineViews = []
        
        if model.depth > 0 {
            for index in 0 ... model.depth {
                if index == model.depth
                { // model 深度绘制线
                    // 横线
                    lineViews.append(UIView().then({ (i) in
                        i.translatesAutoresizingMaskIntoConstraints = false
                        contentView.insertSubview(i, belowSubview: titleLabel)
                        i.heightAnchor(1)
                        i.backgroundColor = .icon
                        i.leadingAnchor(to: titleLabel.leadingAnchor, constant: -lineMargin + 9)
                        i.widthAnchor(23)
                        i.centerYAnchor(to: titleLabel)
                    }))
                }
                else
                { // model 之前深度绘制线
                    // 竖线
                    if model.dontShowLineSet.contains(index) == false {
                        lineViews.append(UIView().then({ (i) in
                            i.translatesAutoresizingMaskIntoConstraints = false
                            contentView.insertSubview(i, belowSubview: titleLabel)
                            i.widthAnchor(1)
                            i.backgroundColor = .icon

                            if model.isLast && index == model.depth - 1 {
                                i.topAnchor()
                                i.bottomAnchor(to: titleLabel.centerYAnchor, constant: 0).isActive = true
                            } else {
                                i.top_bottom(0)
                            }
                            
                            i.leadingAnchor(lineMargin * CGFloat(index + 1))
                        }))
                    }
                }
            }
        }
        
        titleLeadingCons?.constant = leadingMargin
    }
    
    @objc private func chat() {
    }
    
    @objc private func phoneCall() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
