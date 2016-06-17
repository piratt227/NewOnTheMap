//
//  Student.swift
//  On_The_Map
//
//  Created by Aaron Phillips on 6/15/16.
//  Copyright © 2016 Aaron Phillips. All rights reserved.
//

import Foundation

struct Student{
    
    var objectId: String!
    var uniqueKey: String!
    var firstName: String!
    var lastName: String!
    var mapString: String!
    var mediaURL: String!
    var latitude: Float!
    var longitude: Float!
    var createdAt: NSDate!
    var updatedAt: NSDate!
    
    init(dictionary: [String: AnyObject]?){
        if let dictionary = dictionary{
            if let objectId = dictionary["objectId"] as? String {
                self.objectId = objectId
            }
            if let uniqueKey = dictionary["uniqueKey"] as? String {
                self.uniqueKey = uniqueKey
            }
            if let firstName = dictionary["firstName"] as? String{
                self.firstName = firstName
            }
            if let lastName = dictionary["lastName"] as? String{
                self.lastName = lastName
            }
            if let mapString = dictionary["mapString"] as? String {
                self.mapString = mapString
            }
            if let mediaURL = dictionary["mediaURL"] as? String {
                self.mediaURL = mediaURL
            }
            if let latitude = dictionary["latitude"] as? Float {
                self.latitude = latitude
            }
            if let longitude = dictionary["longitude"] as? Float{
                self.longitude = longitude
            }
            if let createdAt = dictionary["createdAt"] as? NSDate{
                self.createdAt = createdAt
            }
            if let updatedAt = dictionary["updatedAt"] as? NSDate{
                self.updatedAt = updatedAt
            }
        }
    }
}