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
    case Unknown
    case Edit
    case Report
    case SeeReflectionText
    case SeeReflectionVideo
    case Share
    case ShareFully
    case Switch
    case Customize
    case SwitchWithoutPassword
    case Decline
    case Approve
    case Delete
    case SubmitTo
}

@objc
public class Ability: NSObject
{
    public let identifier: String
    public let type: String
    public let resourceType: String
    public let resourceIdentifier: String
    public let operation: AbilityOperation
    public let permission: Bool
    
    init(mapper: AbilityMapper)
    {
        identifier = mapper.identifier!
        type = mapper.type!
        resourceType = mapper.resourceType!
        resourceIdentifier = mapper.resourceIdentifier!
        operation = Ability.parseOperation(mapper.operation!)
        permission = mapper.permission!
    }
    
    private static func parseOperation(operationString: String) -> AbilityOperation
    {
        switch operationString {
            case "edit":                    return .Edit
            case "report":                  return .Report
            case "see_reflection_text":     return .SeeReflectionText
            case "see_reflection_video":    return .SeeReflectionVideo
            case "share":                   return .Share
            case "share_fully":             return .ShareFully
            case "switch":                  return .Switch
            case "customize":               return .Customize
            case "switch_without_password": return .SwitchWithoutPassword
            case "decline":                 return .Decline
            case "approve":                 return .Approve
            case "delete":                  return .Delete
            case "submit_to":               return .SubmitTo
            
            default:
                Logger.log.error("Unknown operation type: \(operationString)")
                return .Unknown
            
        }
    }
}
