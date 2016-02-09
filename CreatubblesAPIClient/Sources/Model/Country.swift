//
//  Country.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Country: NSObject
{
    let name: String
    let code: String
    
    init(builder: CountryModelBuilder)
    {
        name = builder.name!
        code = builder.code!
    }
}
