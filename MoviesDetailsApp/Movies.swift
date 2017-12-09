//
//  Movies.swift
//  MoviesDetailsApp
//
//  Created by saurabh srivastava on 08/12/17.
//  Copyright © 2017 moviees. All rights reserved.
//

import UIKit
import RealmSwift

class Movies: Object {
    dynamic var id = ""
    dynamic var name:String = ""
    dynamic var dirName = ""
    dynamic var genre = ""
    dynamic var rating:Float = 0.00
    dynamic var story = ""
    dynamic var imageUrl = ""
    dynamic var open = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func ignoredProperties() -> [String] {
        return ["open"]
    }
    
    func updateModel(_ data:[String:Any]){
        
        if let str = data["Id"] as? String{
            id = str
        }
        
        if let str = data["Title"] as? String{
            name = str
        }
        if let str = data["Rating"] as? Float{
            rating = str
        }
        if let str = data["ReleaseYear"] as? Int{
            dirName = String(str)
        }
        if let str = data["Description"] as? String{
            story = str
        }
        if let str = data["PosterPath"] as? String{
            imageUrl = str
        }
        if let str = data["Genre"] as? String{
            genre = str
        }
        
        
        
    }

}
