//
//  ViewController.swift
//  TreeTableViewDemo
//
//  Created by Beairs on 2020/5/27.
//  Copyright © 2020 Beairs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var models = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TreeTableView"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        initData()
        
        UITableView(frame: CGRect.zero, style: .plain).activeAutoLayout(addtoView: view).then { (i) in
            i.coverOnSuperView()
            i.delegate = self
            i.dataSource = self
            i.register(AddressBookParentCell.self, forCellReuseIdentifier: "parent")
            i.register(AddressBookChildCell.self, forCellReuseIdentifier: "child")
            i.separatorStyle = .none
        }
    }
    
    private func initData() {
        let root = CompanyDepartmentModel()
        root.DeptName = "root"
        root.changeExpand()
        models = [root] + root.nodes
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = models[indexPath.row] as? CompanyDepartmentModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "parent", for: indexPath) as! AddressBookParentCell
            cell.updateUI(model: model)
            
            return cell
        }
        else if let model = models[indexPath.row] as? DepartmentContactUser
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "child", for: indexPath) as! AddressBookChildCell
            cell.selectionStyle = .none
            cell.updateUI(model: model)
            return cell
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let model = models[indexPath.row] as? CompanyDepartmentModel
        {
            var indexes = [IndexPath]()
            let start = indexPath.row
            let count = model.changeExpand()
            
            if count > 0 {
                for i in 1 ... count {
                    indexes.append(IndexPath(row: i + start, section: 0))
                }
            }
            
            if model.isExpand
            {
                if count > 0 {
                    models.insert(contentsOf: model.nodes, at: start + 1)
                    tableView.insertRows(at: indexes, with: .fade)
                }
            }
            else
            {
                if count > 0 {
                    models.removeSubrange((start + 1)...(start + count))
                    tableView.deleteRows(at: indexes, with: .fade)
                }
            }
            
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}



