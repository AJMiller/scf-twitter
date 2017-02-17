//
//  TwitterService.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

class TwitterService: SocialNetworkService {
	var client: TWTRAPIClient

	init(client: TWTRAPIClient?) {
		self.client = client ?? TWTRAPIClient()
	}

	func getMostRecentMessages(dataCallback: @escaping (_ messages: [SocialNetworkMessage]?, _ error: Error?) -> ()) {
		let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
		let params = ["q": "seeclickfix.com"]
		var clientError : NSError?

		let request = self.client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)

		client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
			if connectionError != nil {
				print("Error: \(connectionError)")
			}
			guard data != nil else {
				return
			}

			do {
				DispatchQueue.global(qos: .userInitiated).async {
					let messages = self.transformJSONIntoMessages(jsonData: data)
					// Bounce back to the main thread to update the UI
					DispatchQueue.main.async {
    				dataCallback(messages, nil)
					}
				}
			} catch let jsonError as NSError {
				print("json error: \(jsonError.localizedDescription)")
				dataCallback(nil, jsonError)
			}
		}
	}
	func transformJSONIntoMessages(jsonData: Any?) -> [SocialNetworkMessage]? {
		guard let data = jsonData else {
			return nil
		}
		let json = JSON(data)
		guard let statusData = json["statuses"].array else {
			return nil
		}
		let messages = statusData.map { (status) -> SocialNetworkMessage in
			let author = status["user"]["screen_name"].string ?? ""
			let message = status["text"].string ?? ""
			let image = URL(string: status["user"]["profile_image_url_https"].string ?? "")
			return SocialNetworkMessage(author: author, message: message, image: image)
		}
		return messages
	}
}
