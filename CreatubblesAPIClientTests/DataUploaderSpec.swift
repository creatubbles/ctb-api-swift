//
//  DataUploaderSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class DataUploaderSpec: QuickSpec
{
    override func spec()
    {
        describe("Request Sender")
        {
            it("Should upload data")
            {                
                let builder = CreationUploadModelBuilder()
                builder.identifier = "133"
                builder.uploadUrl = ""
                builder.contentType = "image/jpeg"
                builder.pingUrl = "https://staging.creatubbles.com/api/v2/uploads/133"
                
                let uploadData = CreationUpload(builder: builder)

                let path = NSBundle(forClass: self.dynamicType).URLForResource("creatubbles_logo", withExtension: "jpg")
                let image = UIImage(contentsOfFile: path!.path!)!
                let imageData = UIImageJPEGRepresentation(image, 1)!
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.send(imageData, uploadData: uploadData, progressChanged:
                {
                    (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                    print("\(bytesWritten) \(totalBytesWritten) \(totalBytesExpectedToWrite) ")
                    
                }, completion: { (error) -> Void in
                    print(error)
                })
            }
        }
    }
}