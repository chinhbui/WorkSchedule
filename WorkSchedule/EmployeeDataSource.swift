//
//  EmployeeDataSource.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation
typealias DataSourceType = UITableViewDelegate & UITableViewDataSource & NSObject

class EmployeeDataSource : DataSourceType {
    internal let list = EmployeeViewModel()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        return cell
    }
    
}

class EmployeeViewModel {
    let items : [CellConfigurator] = [
        EmployeeConfig(item: Employee(name: "Sushila Tabita", imageName: "A", selected: false)),
        EmployeeConfig(item: Employee(name: "Håkon Ekenedilichukwu", imageName: "B", selected: false)),
        EmployeeConfig(item: Employee(name: "Arihel Emmalyn", imageName: "C", selected: false)),
        EmployeeConfig(item: Employee(name: "Dejan Rutendo", imageName: "C", selected: false)),
        EmployeeConfig(item: Employee(name: "Dàibhidh Venera", imageName: "C", selected: false)),
        EmployeeConfig(item: Employee(name: "Kristiane Simba", imageName: "C", selected: false)),
        EmployeeConfig(item: Employee(name: "Cowal Hrœrekr", imageName: "C", selected: false))
    ]
}
typealias EmployeeConfig = TableCellConfigurator<EmployeeCell, Employee>

struct Employee {
    let name: String
    let imageName: String
    var selected : Bool = false
}
