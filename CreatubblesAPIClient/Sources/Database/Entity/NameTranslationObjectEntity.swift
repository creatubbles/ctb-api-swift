//
//  NameTranslationObjectEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 29.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import RealmSwift

class NameTranslationObjectEntity: Object
{
    dynamic var code: String?
    dynamic var name: String?
    var original = RealmOptional<Bool>()
}
