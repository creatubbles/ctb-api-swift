//
//  Ability.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 01.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
//See https://partners.creatubbles.com/api/#ability-details for details.
public enum AbilityOperation: Int
{
    case unknown
    case edit
    case report
    case seeReflectionText
    case seeReflectionVideo
    case share
    case shareFully
    case `switch`
    case customize
    case switchWithoutPassword
    case decline
    case approve
    case delete
    case submitTo
    case destroy
}

@objc
open class Ability: NSObject
{
    open let identifier: String
    open let type: String
    open let resourceType: String
    open let resourceIdentifier: String
    open let operation: AbilityOperation
    open let permission: Bool
    
    init(mapper: AbilityMapper)
    {
        identifier = mapper.identifier!
        type = mapper.type!
        resourceType = mapper.resourceType!
        resourceIdentifier = mapper.resourceIdentifier!
        operation = Ability.parseOperation(mapper.operation!)
        permission = mapper.permission!
    }
    
    fileprivate static func parseOperation(_ operationString: String) -> AbilityOperation
    {
        switch operationString {
            case "edit":                    return .edit
            case "report":                  return .report
            case "see_reflection_text":     return .seeReflectionText
            case "see_reflection_video":    return .seeReflectionVideo
            case "share":                   return .share
            case "share_fully":             return .shareFully
            case "switch":                  return .switch
            case "customize":               return .customize
            case "switch_without_password": return .switchWithoutPassword
            case "decline":                 return .decline
            case "approve":                 return .approve
            case "delete":                  return .delete
            case "submit_to":               return .submitTo
            case "destroy":                 return .destroy
            
            default:
                Logger.log.error("Unknown operation type: \(operationString)")
                return .unknown
            
        }
    }
}
