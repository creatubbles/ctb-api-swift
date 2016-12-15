//
//  Ability.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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
    case seeConnectionFilters
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
            case "see_connection_filters":  return .seeConnectionFilters
            
            default:
                Logger.log.error("Unknown operation type: \(operationString)")
                return .unknown
            
        }
    }
}
