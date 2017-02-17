//
//  SocialService.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import Foundation

/**
*  This struct should be the embodiment of all the data we use in each message
*  Each social network's data will need to be parsed to adhere to this structure
*/
struct SocialNetworkMessage {
	var author: String?
	var message: String
	var image: URL?
}

/**
*  This protocol should be adapted for any new social networks
*/
protocol SocialNetworkService {
	func getMostRecentMessages(dataCallback: @escaping (_ messages: [SocialNetworkMessage]?, _ error: Error?) -> ())
	func transformJSONIntoMessages(jsonData: Any?) -> [SocialNetworkMessage]?
}
