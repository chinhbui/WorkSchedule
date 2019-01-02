//
//  Dequeable.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation
protocol Dequeueable {
    static func id() -> String
    static func hasNib() -> Bool
}

extension UITableView {
    func getCell<T:Dequeueable>(forType: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.id()) as? T
    }
    func registerCell(withType cType: Dequeueable.Type) {
        registerCells(withTypes: [cType])
    }
    func registerCells(withTypes cType:[Dequeueable.Type]) {
        for ty in cType {
            if ty.hasNib() {
                register(UINib(nibName: ty.id(), bundle: Bundle.main), forCellReuseIdentifier: ty.id())
            } else {
                if let t = ty as? AnyClass {
                    register(t, forCellReuseIdentifier: ty.id())
                }
            }
        }
    }
}
