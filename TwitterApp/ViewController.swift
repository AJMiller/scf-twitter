//
//  ViewController.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let twitterService = TwitterService(client: nil)
		twitterService.getMostRecentMessages { (messages, error) in
			guard error == nil else {
				print(error)
				return
			}
			print(messages ?? "no messages found")
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

