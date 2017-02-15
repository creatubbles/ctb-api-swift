//
//  DAOAssemblySpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DAOAssemblySpec: QuickSpec
{
    override func spec()
    {
        describe("DAOAssembly")
        {
            it("Should register new DAO")
            {
                let dao = DatabaseDAO()
                let assembly = DAOAssembly()
                assembly.register(dao: dao)
            }
            
            it("Should assembly DAO after register")
            {
                let dao = DatabaseDAO()
                let assembly = DAOAssembly()
                assembly.register(dao: dao)
                let assembledDAO = assembly.assembly(DatabaseDAO.self)
                expect(assembledDAO).notTo(beNil())
            }
            
            it("Should return null when assembled DAO was not registered before")
            {
                let assembly = DAOAssembly()
                let assembledDAO = assembly.assembly(DatabaseDAO.self)
                expect(assembledDAO).to(beNil())
            }
        }
    }
}
