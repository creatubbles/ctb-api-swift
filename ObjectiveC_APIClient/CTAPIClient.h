//
//  CTAPIClient.h
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

#import <Foundation/Foundation.h>
@import CreatubblesAPIClient;

@class CTImageUploadJob;
@protocol CTAPIClientObserver;

@interface CTAPIClient : NSObject
+ (instancetype _Nonnull) sharedInstance;

#pragma mark - Delegate handling
- (void) addObserver:(id <CTAPIClientObserver> _Nonnull)observer;
- (void) removeObserver:(id <CTAPIClientObserver> _Nonnull)observer;

#pragma mark - Public interface - Auth
- (void) loginWithUsername:(NSString *_Nonnull)username password:(NSString *_Nonnull)password completion: (void (^_Nullable)(NSError *_Nullable))completion;
- (void) logout;
- (BOOL) isLoggedIn;
- (NSString* _Nullable) authToken;

#pragma mark - Public interface - Landing URLs
- (void)getLandingURL:(LandingURLType)type completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;
- (void)getLandingURLForCreation:(NSString * _Nonnull)creationId completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;

#pragma mark - Public interface - Creators managment
- (void) getUser:(NSString* _Nonnull) userId completion: (void (^_Nullable)(User *_Nullable, NSError *_Nullable))completion;
- (void) getCurrentUserWithCompletion: (void (^ _Nullable)(User *_Nullable, NSError *_Nullable))completion;
- (void) getCreatorsForUserWithId:(NSString* _Nullable)userId pagingData:(PagingData* _Nullable)pagingData completion:(void (^ _Nullable)(NSArray<User*> * _Nullable, PagingInfo * _Nullable, NSError *_Nullable))completion;
- (void) getManagersForUserWithId:(NSString * _Nullable)userId pagingData:(PagingData * _Nullable)pagingData completion:(void (^ _Nullable)(NSArray<User *> * _Nullable, PagingInfo * _Nullable, NSError * _Nullable))completion;

- (void) newCreator:(NewCreatorData * _Nonnull)creatorData completion:(void (^ _Nullable)(User * _Nullable, NSError * _Nullable))completion;

#pragma mark - Public interface - Galleries managment
- (void) getGalleryWithId:(NSString * _Nonnull)galleryId completion:(void (^ _Nullable)(Gallery * _Nullable, NSError * _Nullable))completion;
- (void) getGalleriesWithUserId:(NSString * _Nullable)userId sort:(SortOrder)sort completion:(void (^ _Nullable)(NSArray<Gallery *> * _Nullable, NSError * _Nullable))completion;
- (void) getGalleriesWithUserId:(NSString * _Nullable)userId pagingData:(PagingData * _Nullable)pagingData sort:(SortOrder)sort completion:(void (^ _Nullable)(NSArray<Gallery *> * _Nullable, PagingInfo * __nullable ,NSError * _Nullable))completion;
- (void) newGalleryWithData:(NewGalleryData * _Nonnull)galleryData completion:(void (^ _Nullable)(Gallery * _Nullable, NSError * _Nullable))completion;

#pragma mark - Public interface - Creation uploads managment
- (NSArray<CreationUploadSessionPublicData *> * _Nonnull) getAllActiveUploadSessionPublicData;
- (NSArray<CreationUploadSessionPublicData *> * _Nonnull) getAllFinishedUploadSessionPublicData;
- (void) startAllNotFinishedUploadSessions;

#pragma mark - Public interface - Creations managment
- (void) getCreationWithid:(NSString * _Nonnull)creationId completion:(void (^ _Nullable)(Creation * _Nullable, NSError * _Nullable))completion;
- (void) getCreationsFromGallery:(NSString * _Nonnull)galleryId userId:(NSString * _Nullable)userId keyword:(NSString * _Nullable)keyword pagingData:(PagingData * _Nullable)pagingData sortOrder:(SortOrder)sortOrder completion:(void (^ _Nullable)(NSArray<Creation *> * _Nullable, PagingInfo * _Nullable, NSError * _Nullable))completion;
- (void) newCreationWithData:(NewCreationData * _Nonnull)creationData completion:(void (^ _Nullable)(Creation * _Nullable, NSError * _Nullable))completion;

@end

@protocol CTAPIClientObserver <NSObject>
- (void) apiClientImageUploadFailed:(CTAPIClient* _Nonnull)client creationData:(CreationUploadSessionPublicData* _Nonnull)data error:(NSError *_Nonnull)error;
- (void) apiClientImageUploadFinished:(CTAPIClient * _Nonnull)client creationData:(CreationUploadSessionPublicData* _Nonnull)data;
- (void) apiClientImageUploadProcessChanged:(CTAPIClient * _Nonnull)apiClient creationData:(CreationUploadSessionPublicData* _Nonnull)data bytesUploaded:(NSInteger)bytesUploaded bytesExpectedToUpload:(NSInteger)bytesExpectedToUpload;
@end




