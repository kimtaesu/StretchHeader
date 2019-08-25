//
//  CellType.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

protocol CellAdapter {
    var itemCount: Int { get }
    func item<T: Equatable>(for index: Int) -> T?
    var identifier: String { get }
}

