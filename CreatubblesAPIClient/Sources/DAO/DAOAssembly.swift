//
//  DAOAssembly.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit

public protocol APIClientDAO: class
{

}

public class DAOAssembly
{
    private var store: Dictionary<String, AnyObject>
    
    init()
    {
        store = Dictionary<String, AnyObject>()
    }
    
    public func register(dao: APIClientDAO)
    {
        let identifier = identifierFrom(daoClass: type(of: dao))
        store[identifier] = dao
    }
    
    public func assembly<T: APIClientDAO>(_ type: T.Type) -> T?
    {
        let identifier = identifierFrom(daoClass: type)
        let dao = store[identifier] as? T
        return dao
    }
    
    private func identifierFrom(daoClass: AnyClass) -> String
    {
        return String(describing: daoClass)
    }
}
