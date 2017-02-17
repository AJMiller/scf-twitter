//
//  ViewController.swift
//  TwitterApp
//
//  Created by AJ Miller on 2/16/17.
//  Copyright © 2017 seeclickfix. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource {

	@IBOutlet weak var twitterTable: UITableView!
	// MARK: - Class Vars
	var messages: [SocialNetworkMessage] = []

	// MARK: - UIViewController Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func viewDidAppear(_ animated: Bool) {
		let twitterService = TwitterService(client: nil)
		twitterService.getMostRecentMessages { (messages, error) in
			guard error == nil else {
				print(error ?? "no error")
				return
			}
			guard messages != nil else {
				print("no messages found")
				return
			}
			self.messages = messages!
			self.twitterTable.reloadData()
		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Data Source Methods
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "twitterCell") as? TwitterCell ?? TwitterCell()
		cell.author.text = messages[indexPath.row].author ?? "No author"
		cell.message.text = messages[indexPath.row].message
		cell.profileImage.sd_setImage(with: messages[indexPath.row].image)
		return cell
	}

}

