//
//  EmployeeCell.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation
class EmployeeCell: UITableViewCell , ConfigurableCell , Dequeueable {
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    static func id() -> String {
        return "EmployeeCell"
    }
    
    static func hasNib() -> Bool {
        return true
    }
    
    typealias DataType = Employee
    func configure(data: Employee) {
        print("configure")
        lblEmployeeName.text = data.name
    }
    override func awakeFromNib() {
        btnCheck.setImage(UIImage(named: "icons8-unchecked-checkbox-50"), for: .normal)
        btnCheck.setImage(UIImage(named: "icons8-checked-checkbox-50"), for: .selected)
        btnCheck.isSelected = false
    }
    
    @IBAction func checkAction(_ sender: Any) {
        if let btn = sender as? UIButton {
            btn.isSelected = !btn.isSelected
        }
        let cellAction = NSNotification.Name(rawValue: "CellAction")
        NotificationCenter.default.post(name: cellAction,
                                        object: nil,
                                        userInfo: ["EmployeeName": lblEmployeeName.text ?? ""])
    }
    
}
