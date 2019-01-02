//
//  CellActions.swift
//  WorkSchedule
//
//  Created by sp on 12/27/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation

enum CellAction: Hashable {
    
    case didSelect
    case willDisplay
    case custom(String)
    
    //hashable
    public var hashValue: Int {
        switch self {
        case .didSelect:
            return 1
        case .willDisplay:
            return 2
        case .custom(let custom):
            return custom.hashValue
        }
    }
    
    public static func ==(lhs: CellAction, rhs: CellAction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
extension CellAction {
    static let notificationName = NSNotification.Name(rawValue: "CellAction")
    
    public func invoke(cell: UIView) {
        NotificationCenter.default.post(name: CellAction.notificationName,
                                        object: nil,
                                        userInfo: ["data": CellActionEventData(action: self, cell: cell)])
    }
}
struct CellActionEventData {
    let action: CellAction
    let cell: UIView
}

class CellActionProxy {
    
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
        if let action = self.actions[key] {
            action(configurator, cell)
        }
    }
    
    @discardableResult
    func on<CellType, DataType>(_ action: CellAction, handler: @escaping ((TableCellConfigurator<CellType, DataType>, CellType) -> Void)) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (c, cell) in
            handler(c as! TableCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}
