//
//  Message.swift
//  Turfy
//
//  Created by Lawrence Dawson on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import Firebase

struct Message {
	let id: String
	let sender: String
	let recipient: String
	let text: String
	let location: String
	let radius: Int
	let sentAt: NSDate
	let expires: Int
	let formatter = DateFormatter()
	
	init(id: String, sender: String, recipient: String, location: String, text:String, radius: Int, expires: Int = 10) {
		self.id = id
		self.sender = sender
		self.recipient = recipient
		self.text = text
		self.location = location
		self.radius = radius
		self.sentAt = NSDate()
		self.expires = expires
	}
    
    init(snapshot: FIRDataSnapshot) {
        id = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
            sender = snapshotValue["sender"] as! String
            recipient = snapshotValue["recipient"] as! String
            text = snapshotValue["text"] as! String
            location = snapshotValue["location"] as! String
            radius = snapshotValue["radius"] as! Int
            sentAt = snapshotValue["sentAt"] as! NSDate
            expires = snapshotValue["expires"] as! Int
    }
    
	func toAnyObject() -> Any {
		return [
            "sender": sender,
            "recipient": recipient,
            "text": text,
            "location": location,
            "radius": radius,
            "sentAt": sentAt.hashValue,
            "expires": expires,
		]
	}
}
