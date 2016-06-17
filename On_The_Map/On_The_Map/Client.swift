//
//  Client.swift
//  On_The_Map
//
//  Created by Aaron Phillips on 6/15/16.
//  Copyright © 2016 Aaron Phillips. All rights reserved.
//

import Foundation

class Client{
    
// Variables
    static var sharedInstance = Client()
    var session: NSURLSession
    
// Initializer
    init(){
        session = NSURLSession.sharedSession()
    }

// Shared Instance
    //class func sharedInstance() -> Client{
        //struct Singleton {
            //static var sharedInstance = Client()
        //}
        //return Singleton.sharedInstance
    //}
    
// Udacity Login GET Method
    func udacityLogin(email: String, password: String, completionHandler: (success: Bool, result: [String: AnyObject]?, errorText: String?) -> Void) {

        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\" : {\"username\" : \"\(email)\", \"password\" : \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)

        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error == nil{
                if let data = data{
                    let parsedResult: AnyObject!
                    do{
                        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                        if let parsedResult = parsedResult["account"] as? [String: AnyObject]{
                            if let existingAccount = parsedResult["registered"] as? Bool{
                                if existingAccount == true{
                                    if let key = parsedResult["key"] as? String{
                                        if let registered = parsedResult["registered"] as? Bool{
                                            let dictionary: [String: AnyObject] = ["uniqueKey": key, "registered": registered]
                                            completionHandler(success: true, result: dictionary, errorText: "")
                                            print(dictionary)
                                            self.getUserData(key){ (success, result, error) in
                                            }
                                        }
                                        completionHandler(success: false, result: nil, errorText: "error")
                                    }
                                    completionHandler(success: false, result: nil, errorText: "error")
                                }
                                completionHandler(success: false, result: nil, errorText: "error")
                            }
                            completionHandler(success: false, result: nil, errorText: "error")
                        }
                    }catch{
                        print("could not parse the data as JSON")
                        return
                    }
                }
            }
        }
        task.resume()
    }
    
    func getUserData(userKey: String?, completionHandler: (success: Bool, result: [String: AnyObject]?, errorText: String?) -> Void) {
        let url = NSURL(string: "https://www.udacity.com/api/users/" + userKey!)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard (error == nil) else {
                completionHandler(success: false, result: nil, errorText: "\(error)")
                print(error)
                return
            }
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                completionHandler(success: false, result: nil, errorText: "\(error)")
                print("Your request returned a status code other than 2xx!")
                return
            }
            guard let data = data else{
                completionHandler(success: false, result: nil, errorText: "\(error)")
                print("No data returned")
                return
            }
            
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            self.parseJSONDataForUserData(newData, completionHandler: completionHandler)
        }
        task.resume()
    }
    
    func parseJSONDataForLogin(data: NSData, completionHandler: (success: Bool, result: [String: AnyObject]?, errorText: String?) -> Void) {
        do{
            let parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]
            if let parsedResult = parsedResult{
                if parsedResult["error"] != nil{
                    completionHandler(success: false, result: nil, errorText: "error")
                    return
                }
                if let parsedResult = parsedResult["account"] as? [String: AnyObject]{
                    if let existingAccount = parsedResult["registered"] as? Bool{
                        if existingAccount == true{
                            if let key = parsedResult["key"] as? String{
                                if let registered = parsedResult["registered"] as? Bool{
                                let dictionary: [String: AnyObject] = ["uniqueKey": key, "registered": registered]
                                completionHandler(success: true, result: dictionary, errorText: "")
                                print(dictionary)
                                }
                                completionHandler(success: false, result: nil, errorText: "error")
                            }
                            completionHandler(success: false, result: nil, errorText: "error")
                        }
                        completionHandler(success: false, result: nil, errorText: "error")
                    }
                    completionHandler(success: false, result: nil, errorText: "error")
                }
                completionHandler(success: false, result: nil, errorText: "error")
            }
            completionHandler(success: false, result: nil, errorText: "error")
            }catch{
            completionHandler(success: false, result: nil, errorText: "Error")
        }
    }
    
    func parseJSONDataForUserData(data: NSData, completionHandler: (success: Bool, result: [String: AnyObject]?, errorText: String?) -> Void) {
        do{
            if let parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]{
                
                let newResult = parsedResult["user"] as? [String:AnyObject]
                if let newResult = newResult{
                    if let firstName = newResult["first_name"] as? String{
                        if let lastName = newResult["last_name"] as? String{
                            let dictionary: [String: AnyObject] = ["firstName": firstName, "lastName": lastName]
                            print(dictionary)
                            completionHandler(success: true, result: dictionary, errorText: "")
                        }
                        completionHandler(success: false, result: nil, errorText: "Error")
                    }
                    completionHandler(success: false, result: nil, errorText: "Error")
                }
                completionHandler(success: false, result: nil, errorText: "Error")
            }
            completionHandler(success: false, result: nil, errorText: "Error")
            
        }catch{
            print("Catch error")
        }
    }
}
