//
//  OAuth2ClientConfig.swift
//  OAuth2
//
//  Created by Pascal Pfiffner on 16/11/15.
//  Copyright © 2015 Pascal Pfiffner. All rights reserved.
//

import Foundation


/**
Client configuration object that holds on to client-server specific configurations such as client id, -secret and server URLs.
*/
public class OAuth2ClientConfig {
	
	/// The client id.
	public final var clientId: String?
	
	/// The client secret, usually only needed for code grant.
	public final var clientSecret: String?
	
	/// The name of the client, e.g. for use during dynamic client registration.
	public final var clientName: String?
	
	/// The URL to authorize against.
	public final let authorizeURL: URL
	
	/// The URL where we can exchange a code for a token.
	public final var tokenURL: URL?
	
	/// Where a logo/icon for the app can be found.
	public final var logoURL: URL?
	
	/// The scope currently in use.
	public var scope: String?
	
	/// The redirect URL string currently in use.
	public var redirect: String?
	
	/// All redirect URLs passed to the initializer.
	public var redirectURLs: [String]?
	
	/// The receiver's access token.
	public var accessToken: String?

	/// The receiver's id token.  Used by Google + and AWS Cognito
	public var idToken: String?

	/// The access token's expiry date.
	public var accessTokenExpiry: Date?
	
	/// If set to true (the default), uses a keychain-supplied access token even if no "expires_in" parameter was supplied.
	public var accessTokenAssumeUnexpired = true
	
	/// The receiver's long-time refresh token.
	public var refreshToken: String?
	
	/// The URL to register a client against.
	public final var registrationURL: URL?
	
	/// How the client communicates the client secret with the server. Defaults to ".None" if there is no secret, ".ClientSecretPost" if
	/// "secret_in_body" is `true` and ".ClientSecretBasic" otherwise. Interacts with the `authConfig.secretInBody` client setting.
	public final var endpointAuthMethod = OAuth2EndpointAuthMethod.None
	
	
	/**
	Initializer to initialize properties from a settings dictionary.
	*/
	public init(settings: OAuth2JSON) {
		clientId = settings["client_id"] as? String
		clientSecret = settings["client_secret"] as? String
		clientName = settings["client_name"] as? String
		
		// authorize URL
		var aURL: URL?
		if let auth = settings["authorize_uri"] as? String {
			aURL = URL(string: auth)
		}
		authorizeURL = aURL ?? URL(string: "http://localhost")!
		
		// token, registration and logo URLs
		if let token = settings["token_uri"] as? String {
			tokenURL = URL(string: token)
		}
		if let registration = settings["registration_uri"] as? String {
			registrationURL = URL(string: registration)
		}
		if let logo = settings["logo_uri"] as? String {
			logoURL = URL(string: logo)
		}
		
		// client authentication options
		scope = settings["scope"] as? String
		if let redirs = settings["redirect_uris"] as? [String] {
			redirectURLs = redirs
			redirect = redirs.first
		}
		if let inBody = settings["secret_in_body"] as? Bool where inBody {
			endpointAuthMethod = .ClientSecretPost
		}
		else if nil != clientSecret {
			endpointAuthMethod = .ClientSecretBasic
		}
		
		// access token options
		if let assume = settings["token_assume_unexpired"] as? Bool {
			accessTokenAssumeUnexpired = assume
		}
	}
	
	
	/**
	Update properties from response data.
	
	This method assumes values are present with the standard names, such as `access_token`, and assigns them to its properties.
	
	- parameter json: JSON data returned from a request
	*/
	func updateFromResponse(_ json: OAuth2JSON) {
		if let access = json["access_token"] as? String {
			accessToken = access
		}
		if let idtoken = json["id_token"] as? String {
			idToken = idtoken
		}
		accessTokenExpiry = nil
		if let expires = json["expires_in"] as? TimeInterval {
			accessTokenExpiry = Date(timeIntervalSinceNow: expires)
		}
		else if let expires = json["expires_in"] as? String {			// when parsing implicit grant from URL fragment
			accessTokenExpiry = Date(timeIntervalSinceNow: Double(expires) ?? 0.0)
		}
		if let refresh = json["refresh_token"] as? String {
			refreshToken = refresh
		}
	}
	
	/**
	Creates a dictionary of credential items that can be stored to the keychain.
	
	- returns: A storable dictionary with credentials
	*/
	func storableCredentialItems() -> [String: NSCoding]? {
		guard let clientId = clientId where !clientId.isEmpty else { return nil }
		
		var items: [String: NSCoding] = ["id": clientId]
		if let secret = clientSecret {
			items["secret"] = secret
		}
		items["endpointAuthMethod"] = endpointAuthMethod.rawValue
		return items
	}
	
	/**
	Creates a dictionary of token items that can be stored to the keychain.
	
	- returns: A storable dictionary with token data
	*/
	func storableTokenItems() -> [String: NSCoding]? {
		guard let access = accessToken where !access.isEmpty else { return nil }
		
		var items: [String: NSCoding] = ["accessToken": access]
		if let date = accessTokenExpiry where date == (date as NSDate).laterDate(Date()) {
			items["accessTokenDate"] = date
		}
		if let refresh = refreshToken where !refresh.isEmpty {
			items["refreshToken"] = refresh
		}
		if let idtoken = idToken where !idtoken.isEmpty {
			items["idToken"] = idtoken
		}
        
		return items
	}
	
	/**
	Updates receiver's instance variables with values found in the dictionary. Returns a list of messages that can be logged on debug.
	
	- parameter items: The dictionary representation of the data to store to keychain
	- returns: An array of strings containing log messages
	*/
	func updateFromStorableItems(_ items: [String: NSCoding]) -> [String] {
		var messages = [String]()
		if let id = items["id"] as? String {
			clientId = id
			messages.append("Found client id")
		}
		if let secret = items["secret"] as? String {
			clientSecret = secret
			messages.append("Found client secret")
		}
		if let methodName = items["endpointAuthMethod"] as? String, let method = OAuth2EndpointAuthMethod(rawValue: methodName) {
			endpointAuthMethod = method
		}
		if let token = items["accessToken"] as? String where !token.isEmpty {
			if let date = items["accessTokenDate"] as? Date {
				if date == (date as NSDate).laterDate(Date()) {
					messages.append("Found access token, valid until \(date)")
					accessTokenExpiry = date
					accessToken = token
				}
				else {
					messages.append("Found access token but it seems to have expired")
				}
			}
			else if accessTokenAssumeUnexpired {
				messages.append("Found access token but no expiration date, assuming unexpired (set `accessTokenAssumeUnexpired` to false to discard)")
				accessToken = token
			}
			else {
				messages.append("Found access token but no expiration date, discarding (set `accessTokenAssumeUnexpired` to true to still use it)")
			}
		}
		if let token = items["refreshToken"] as? String where !token.isEmpty {
			messages.append("Found refresh token")
			refreshToken = token
		}
		if let idtoken = items["idToken"] as? String where !idtoken.isEmpty {
			messages.append("Found id token")
			idToken = idtoken
		}
		return messages
	}
	
	/** Forgets the configuration's client id and secret. */
	public func forgetCredentials() {
		clientId = nil
		clientSecret = nil
	}
	
	/** Forgets the configuration's current tokens. */
	public func forgetTokens() {
		accessToken = nil
		accessTokenExpiry = nil
		refreshToken = nil
		idToken = nil
	}
}

