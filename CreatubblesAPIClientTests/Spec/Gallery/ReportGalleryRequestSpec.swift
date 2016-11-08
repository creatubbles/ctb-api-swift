//
//  ReportGalleryRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportGalleryRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Report gallery request") {
            
            it("Should have proper endpoint for gallery") {
                let galleryId = "galleryId"
                let message = "message"
                let request = ReportGalleryRequest(galleryId: galleryId, message: message)
                expect(request.endpoint).to(equal("galleries/\(galleryId)/report"))
            }
            
            it("Should have proper method") {
                let galleryId = "galleryId"
                let message = "message"
                let request = ReportGalleryRequest(galleryId: galleryId, message: message)
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set") {
                let galleryId = "galleryId"
                let message = "message"
                
                let request = ReportGalleryRequest(galleryId: galleryId, message: message)
                let params = request.parameters
                expect(params["message"] as? String).to(equal(message))
            }
        }
    }
}
