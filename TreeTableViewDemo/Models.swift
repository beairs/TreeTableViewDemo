//
//  Models.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import Foundation

class CompanyDepartmentModel {
    var DeptName = "DeptName"
    
    /// 是否展开
    var isExpand: Bool {
        return _isExpand
    }
    /// 设计成私有变量, 是想调用者只能通过方法控制
    private var _isExpand = false

    /// 下面两个变量都是从接口返回的数据源, 以字典的形式接收
    var MineList = [[String:Any]]()
    var Children = [[String:Any]]()
    /// 当前节点深度
    var depth: Int = 0
    /// 提供给外部使用的节点数, 由两部分构成:联系人列表和可展开的子节点列表
    var nodes: [Any] { return mineList + childrenList }
    /// 是否当前组内最后一个
    var isLast = true
    /// 记录不需要显示线条的列
    var dontShowLineSet: Set<Int> = []
    
    private lazy var _childrenList : [CompanyDepartmentModel] = []
    /// 懒加载, 返回可展开的子节点列表
    var childrenList: [CompanyDepartmentModel] {
        if Children.count > 0 && _childrenList.count == 0 {
            Children.forEachHandle { (index, isEnd, dict) in
                let model = CompanyDepartmentModel()
                model.depth = depth + 1
                model.DeptName = "parent-\(model.depth)"
                model.dontShowLineSet = dontShowLineSet
                
                if isEnd == false {
                    model.isLast = false
                }
                
                if isLast {
                    model.dontShowLineSet.insert(depth - 1)
                }
                _childrenList.append(model)
            }
        }
        return _childrenList
    }
    private lazy var _mineList : [DepartmentContactUser] = []
    /// 懒加载, 返回联系人列表
    var mineList: [DepartmentContactUser] {
        if MineList.count > 0 && _mineList.count == 0 {
            MineList.forEachHandle { (index, isEnd, dict) in
                let model = DepartmentContactUser()
                model.depth = depth + 1
                model.RealName = "child-\(model.depth)"
                model.dontShowLineSet = dontShowLineSet
                
                if isEnd == false || Children.count > 0 {
                    model.isLast = false
                }
                
                if isLast {
                    model.dontShowLineSet.insert(depth - 1)
                }
                _mineList.append(model)
            }
        }
        return _mineList
    }
    /// 改变展开状态, 并返回造成影响的节点数
    @discardableResult
    func changeExpand() -> Int {
        _isExpand.toggle()
        if isExpand {
            return nodes.count
        } else {
            return resetNodes()
        }
    }
    
    /// 重置 childrenList 的展开状态, 并用递归返回总共影响的节点数
    func resetNodes() -> Int {
        _isExpand = false
        var totalCount = nodes.count
        for node in childrenList {
            if node.isExpand {
                // 递归删除
                totalCount += node.resetNodes()
            }
        }
        return totalCount
    }
    
    required init() {
        if Children.count < 1 {
            Children.append([:])
            Children.append([:])
        }
        if MineList.count < 1 {
            MineList.append([:])
            MineList.append([:])
        }
    }
}


class DepartmentContactUser {
    var CellPhoneNumber = 0
    var HeadImage = ""
    var IsCanCall = true
    var RealName = ""
    var isSelected = false
    var depth: Int = 0
    var dontShowLineSet : Set<Int> = []
    var isLast = true
    var Remarks = "暂无"
}
