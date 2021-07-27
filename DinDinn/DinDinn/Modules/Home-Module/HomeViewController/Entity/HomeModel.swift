//
//  HomeModel.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let BRIEF = "brief"
private let FILESOURCE = "filesource"
private let IMAGEURL = "image_url"

class HomeModel: Mappable {
    
    internal var id:String?
    internal var title:String?
    internal var brief:String?
    internal var filesource:String?
    internal var imageurl: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[ID]
        title <- map[TITLE]
        brief <- map[BRIEF]
        filesource <- map[FILESOURCE]
        imageurl <- map[IMAGEURL]
    }
}
