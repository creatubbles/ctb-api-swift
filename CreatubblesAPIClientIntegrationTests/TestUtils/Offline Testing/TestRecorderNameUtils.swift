//
//  APIClientError.swift
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
//

import UIKit
@testable import CreatubblesAPIClient

class TestRecorderNameUtils {
    class func filenameForRequest(request: Request, isLoggedIn: Bool?) -> String {
        var nameComponents = Array<String>()
        nameComponents.append(request.endpoint)
        nameComponents.append(request.method.rawValue)
        nameComponents.append(String(String(describing: request.parameters).hashValue))
        nameComponents.append("loggedIn;\(String(describing: isLoggedIn))")

        nameComponents = [nameComponents.joined(separator: "_")]

        let name = String(nameComponents.first!.characters.map { $0 == "/" ? "." : $0 })
        return name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    class func getInputFilePathForFileName(fileName: String) -> String? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first {
            return dirPath.stringByAppendingPathComponent(fileName)
        }
        return nil
    }
}
