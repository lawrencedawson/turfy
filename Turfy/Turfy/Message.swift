//
//  Message.swift
//  Turfy
//
//  Created by Lawrence Dawson on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation

import Firebase
import UIKit
import MapKit
import CoreLocation

struct GeoKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let radius = "radius"
    static let id = "id"
    static let sender = "sender"
    static let text = "message"
    static let eventType = "eventType"
}

enum EventType: String {
    case onEntry = "On Entry"
    case onExit = "On Exit"
}

struct Message {
	let id: String
	let sender: String
	let recipient: String
	let text: String

	let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let eventType: EventType
	let sentAt: String
	let expires: String
	let dateformatter = DateFormatter()

	
    init(id: String, sender: String, recipient: String, text: String, latitude: Double, longitude: Double, radius: Double, eventType: String, expires: Int = 2) {
		
		let timeInterval = expires*86400
		self.dateformatter.dateFormat = "dd/MM/yy h:mm"
		
		self.id = id
		self.sender = sender
		self.recipient = recipient
		self.text = text
		self.eventType = EventType(rawValue: eventType)!
		self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		
		self.radius = CLLocationDistance(radius)
		self.sentAt = self.dateformatter.string(from: NSDate() as Date)
		self.expires = self.dateformatter.string(from: NSDate(timeIntervalSinceNow: Double(timeInterval)) as Date)
		
	}
    
    init(snapshot: FIRDataSnapshot) {
		id = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
            sender = snapshotValue["sender"] as! String
            recipient = snapshotValue["recipient"] as! String
            text = snapshotValue["text"] as! String
			eventType = snapshotValue
            radius = snapshotValue["radius"] as! Int
            sentAt = snapshotValue["sentAt"] as! String
            expires = snapshotValue["expires"] as! Int
		
		}
	
	
	func toAnyObject() -> Any {
		return [
            "sender": sender,
            "recipient": recipient,
            "text": text,

            "radius": radius,
            "sentAt": sentAt,
            "expires": expires,
		]
	}
}
