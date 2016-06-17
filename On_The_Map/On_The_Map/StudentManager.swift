//
//  StudentManager.swift
//  On_The_Map
//
//  Created by Aaron Phillips on 6/16/16.
//  Copyright © 2016 Aaron Phillips. All rights reserved.
//

import Foundation

class StudentManager: NSObject{
    
    var userStudent: Student?
    static var userKey: String = ""
    static var udacityLoginDictionary: [String:AnyObject] = [:]
    
// Shared Instance
    class func sharedInstance() -> StudentManager{
        struct Singleton {
            static var sharedInstance = StudentManager()
            
        }
        return Singleton.sharedInstance
    }
}
