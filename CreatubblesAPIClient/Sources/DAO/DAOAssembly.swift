//
//  CreationUploadMapper.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public protocol APIClientDAO: class
{
    init(dependencies: DAODependencies)
}

public class DAODependencies
{
    public let requestSender: RequestSender
    
    public init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
}

public class DAOAssembly
{
    private var store: Dictionary<String, AnyObject>
    private let dependencies: DAODependencies
    
    init(dependencies: DAODependencies)
    {
        self.dependencies = dependencies
        store = Dictionary<String, AnyObject>()
    }
    
    public func register(dao: APIClientDAO)
    {
        let identifier = identifierFrom(daoClass: type(of: dao))
        store[identifier] = dao
    }
    
    public func assembly<T: APIClientDAO>(_ type: T.Type) -> T
    {
        let identifier = identifierFrom(daoClass: type)
        if let dao = store[identifier] as? T
        {
            return dao
        }
        else
        {
            assertionFailure("DAO with identifier: \(identifier) was not registered yet.")
            return T(dependencies: dependencies)
        }
    }
    
    public func isDAORegistered<T: APIClientDAO>(_ type: T.Type) -> Bool
    {
        let identifier = identifierFrom(daoClass: type)
        return store[identifier] as? T != nil
    }
    
    
    private func identifierFrom(daoClass: AnyClass) -> String
    {
        return String(describing: daoClass)
    }
}
