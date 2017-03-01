//
//  LocalizationConfiguratorSpec
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

import Quick
import Nimble
@testable import CreatubblesAPIClient

class LocalizationConfiguratorSpec: QuickSpec
{
    override func spec()
    {
        describe("Forcing a default language")
        {
            afterEach { () -> () in
                LocalizationConfigurator.forcedLanguage = nil
            }
            
            it("Should return nil if the property not set") {
                expect(LocalizationConfigurator.forcedLanguage).to(beNil())
            }
            
            it("Should return correct value if it's set") {
                let localization = "de"
                LocalizationConfigurator.forcedLanguage = localization
                expect(LocalizationConfigurator.forcedLanguage).to(equal(localization))
            }
        }
    }
}
