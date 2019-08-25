//
//  SectionModelType.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

public protocol IdentifiableType {
    associatedtype Identity: Hashable
    
    var identity : Identity { get }
}


protocol SectionModelType: IdentifiableType  where Item: IdentifiableType, Item: Equatable  {
    associatedtype Item
    
    var items: [Item] { get }
    
    init(items: [Item])
}
