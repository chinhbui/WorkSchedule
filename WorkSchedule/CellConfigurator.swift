//
//  CellConfigurator.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    static var reuseIdentifier: String { get }
    associatedtype DataType
    func configure(data:DataType)
}
extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell:UIView)
}

class TableCellConfigurator<CellType:ConfigurableCell,DataType> : CellConfigurator  where CellType.DataType == DataType, CellType : UITableViewCell {
    static var reuseId: String {
        return String(describing: CellType.self)
    }
    
    let item : DataType
    init(item:DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as? CellType)?.configure(data: item)
    }
}

