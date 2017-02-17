//
//  TwitterService.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import Foundation
import TwitterKit

class TwitterService: SocialNetworkService {
	var client: TWTRAPIClient

	init(client: TWTRAPIClient?) {
		self.client = client ?? TWTRAPIClient()
	}

	func getMostRecentMessages() {
		let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
		let params = ["q": "seeclickfix.com"]
		var clientError : NSError?

		let request = self.client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)

		client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
			if connectionError != nil {
				print("Error: \(connectionError)")
			}

			do {
				let json = try JSONSerialization.jsonObject(with: data!, options: [])
				print("json: \(json)")
			} catch let jsonError as NSError {
				print("json error: \(jsonError.localizedDescription)")
			}
		}
	}
}
