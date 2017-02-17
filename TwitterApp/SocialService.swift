//
//  SocialService.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import Foundation

/**
*  This protocol should be adapted for any new social networks
*/
protocol SocialNetworkService {
	func getMostRecentMessages()
}
