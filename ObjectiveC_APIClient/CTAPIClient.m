//
//  CTAPIClient.m
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


#import "CTAPIClient.h"
#import "CTImageUploadJob.h"

@interface CTAPIClient() <CreatubblesAPIClientDelegate>
@property (strong, nonatomic, readonly) NSHashTable *observers;
@property (nonatomic, strong, readonly) CreatubblesAPIClient *client;
@end

@implementation CTAPIClient
#pragma mark - Init
+ (instancetype) sharedInstance
{
    static CTAPIClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAPIClient alloc] initInstance];
    });
    
    return sharedInstance;
}

- (instancetype) initInstance
{
    self = [super self];
    if(self)
    {
        _observers = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
        [self setupClient];
    }
    return self;
}

- (instancetype)init
{
    NSAssert(NO, @"default construction called - use shared instance instead");
    return nil;
}

- (void) setupClient
{
    CreatubblesAPIClientSettings *settings =[[CreatubblesAPIClientSettings alloc]
                                             initWithAppId:@"APP_ID"
                                              appSecret:@"APP_SECRET"
                                               tokenUri:@"https://staging.creatubbles.com/api/v2/oauth/token"
                                           authorizeUri:@"https://staging.creatubbles.com/api/v2/oauth/token"
                                                baseUrl:@"https://staging.creatubbles.com"
                                             apiVersion:@"v2" apiPrefix:@"api"];
    _client = [[CreatubblesAPIClient alloc] initWithSettings:settings];
    self.client.delegate = self;
}
#pragma mark - Observers handling
- (void) addObserver:(id <CTAPIClientObserver>)observer;
{
    if(![self.observers containsObject:observer])
    {
        [self.observers addObject:observer];
    }
}

- (void) removeObserver:(id <CTAPIClientObserver>)observer;
{
    [self.observers removeObject:observer];
}

#pragma mark - Public interface - Auth
- (void) loginWithUsername:(NSString *)username password:(NSString *)password completion: (void (^)(NSError *_Nullable))completion
{
    [self.client _login:username password:password completion:completion];
}

- (void) logout;
{
    [self.client logout];
}

- (BOOL) isLoggedIn;
{
    return [self.client isLoggedIn];
}

- (NSString *)authToken
{
    return [self.client _authenticationToken];
}

#pragma mark - Landing URLs
- (void) getLandingURL:(LandingURLType)type completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getLandingURL:type completion:completion];
}

- (void) getLandingURLForCreation:(NSString * _Nonnull)creationId completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getLandingURLForCreation:creationId completion:completion];
}

#pragma mark - Public interface - Creators managment
- (void) getUser:(NSString*) userId completion: (void (^)(User *_Nullable, NSError *_Nullable))completion
{
    [self.client _getUser:userId completion:completion];
}

- (void) getCurrentUserWithCompletion: (void (^ _Nullable)(User *_Nullable, NSError *_Nullable))completion
{
    [self.client _getCurrentUser:completion];
}

- (void) getCreatorsForUserWithId:(NSString* _Nullable)userId pagingData:(PagingData* _Nullable)pagingData completion:(void (^ _Nullable)(NSArray<User*> * _Nullable, PagingInfo * _Nullable, NSError *_Nullable))completion
{
    [self.client _getCreators:userId pagingData:pagingData completion:completion];
}

- (void) getManagersForUserWithId:(NSString * _Nullable)userId pagingData:(PagingData * _Nullable)pagingData completion:(void (^ _Nullable)(NSArray<User *> * _Nullable,PagingInfo * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getManagers:userId pagingData:pagingData completion:completion];
}

- (void) getCreatorsForUserWithId:(NSString * _Nullable)userId completion:(void (^ _Nullable)(NSArray<User *> * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getCreators:userId completion:completion];
}

- (void) getManagersForUserWithId:(NSString * _Nullable)userId completion:(void (^ _Nullable)(NSArray<User *> * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getManagers:userId completion:completion];
}

- (void) newCreator:(NewCreatorData * _Nonnull)creatorData completion:(void (^ _Nullable)(User * _Nullable, NSError * _Nullable))completion;
{
    [self.client _newCreator:creatorData completion:completion];
}

#pragma mark - Public interface - Galleries managment
- (void) getGalleryWithId:(NSString * _Nonnull)galleryId completion:(void (^ _Nullable)(Gallery * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getGallery:galleryId completion:completion];
}

- (void) getGalleriesWithUserId:(NSString * _Nullable)userId pagingData:(PagingData * _Nullable)pagingData sort:(SortOrder)sort completion:(void (^ _Nullable)(NSArray<Gallery *> * _Nullable, PagingInfo * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getGalleries:userId pagingData:pagingData sort:sort completion:completion];
}

- (void) newGalleryWithData:(NewGalleryData * _Nonnull)galleryData completion:(void (^ _Nullable)(Gallery * _Nullable, NSError * _Nullable))completion;
{
    [self.client _newGallery:galleryData completion:completion];
}

- (void) getGalleriesWithUserId:(NSString * _Nullable)userId sort:(SortOrder)sort completion:(void (^ _Nullable)(NSArray<Gallery *> * _Nullable, NSError * _Nullable))completion
{
    [self.client _getGalleries:userId sort:sort completion:completion];
}

#pragma mark - Public interface - Creation uploads managment
- (NSArray<CreationUploadSessionPublicData *> * _Nonnull) getAllActiveUploadSessionPublicData;
{
    return [self.client _getAllActiveUploadSessionPublicData];
}

- (NSArray<CreationUploadSessionPublicData *> * _Nonnull) getAllFinishedUploadSessionPublicData;
{
    return [self.client _getAllFinishedUploadSessionPublicData];
}

- (void) startAllNotFinishedUploadSessions
{
    [self.client _startAllNotFinishedUploadSessions:nil];
}

#pragma mark - Public interface - Creations managment
- (void) getCreationWithid:(NSString * _Nonnull)creationId completion:(void (^ _Nullable)(Creation * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getCreation:creationId completion:completion];
}

- (void) getCreationsFromGallery:(NSString * _Nonnull)galleryId userId:(NSString * _Nullable)userId keyword:(NSString * _Nullable)keyword pagingData:(PagingData * _Nullable)pagingData sortOrder:(SortOrder)sortOrder completion:(void (^ _Nullable)(NSArray<Creation *> * _Nullable, PagingInfo * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getCreations:galleryId userId:userId keyword:keyword pagingData:pagingData sortOrder:sortOrder completion:completion];
}

- (void) getCreationsFromGallery:(NSString * _Nonnull)galleryId userId:(NSString * _Nullable)userId keyword:(NSString * _Nullable)keyword sortOrder:(SortOrder)sortOrder completion:(void (^ _Nullable)(NSArray<Creation *> * _Nullable, NSError * _Nullable))completion;
{
    [self.client _getCreations:galleryId userId:userId keyword:keyword sortOrder:sortOrder completion:completion];
}

- (void) newCreationWithData:(NewCreationData * _Nonnull)creationData completion:(void (^ _Nullable)(Creation * _Nullable, NSError * _Nullable))completion;
{
    [self.client _newCreation:creationData completion:completion];
}

#pragma mark - CreatubblesAPIClientDelegate
- (void)creatubblesAPIClientImageUploadFailed:(CreatubblesAPIClient *)apiClient uploadSessionData:(CreationUploadSessionPublicData *)uploadSessionData error:(NSError *)error
{
    for(id<CTAPIClientObserver> observer in self.observers)
    {
        if([observer respondsToSelector:@selector(apiClientImageUploadFailed:creationData:error:)])
        {
            [observer apiClientImageUploadFailed:self creationData:uploadSessionData error:error];
        }
    }
}

- (void)creatubblesAPIClientImageUploadFinished:(CreatubblesAPIClient *)apiClient uploadSessionData:(CreationUploadSessionPublicData *)uploadSessionData
{
    for(id<CTAPIClientObserver> observer in self.observers)
    {
        if([observer respondsToSelector:@selector(apiClientImageUploadFinished:creationData:)])
        {
            [observer apiClientImageUploadFinished:self creationData:uploadSessionData];
        }
    }
}

- (void)creatubblesAPIClientImageUploadProcessChanged:(CreatubblesAPIClient *)apiClient uploadSessionData:(CreationUploadSessionPublicData *)uploadSessionData bytesUploaded:(NSInteger)bytesUploaded bytesExpectedToUpload:(NSInteger)bytesExpectedToUpload
{
    for(id<CTAPIClientObserver> observer in self.observers)
    {
        if([observer respondsToSelector:@selector(apiClientImageUploadProcessChanged:creationData:bytesUploaded:bytesExpectedToUpload:)])
        {
            [observer apiClientImageUploadProcessChanged:self creationData:uploadSessionData bytesUploaded:bytesUploaded bytesExpectedToUpload:bytesExpectedToUpload];
        }
    }
}

@end
