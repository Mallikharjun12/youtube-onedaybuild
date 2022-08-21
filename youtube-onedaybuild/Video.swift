//
//  Video.swift
//  youtube-onedaybuild
//
//  Created by admin on 21/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import Foundation

struct Video: Decodable{
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum Codingkeys: String,CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Codingkeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: Codingkeys.self, forKey: .snippet)
        
        // parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // parse the publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // parse the thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: Codingkeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: Codingkeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // parse videoId
        let resourceContainer = try snippetContainer.nestedContainer(keyedBy: Codingkeys.self, forKey: .resourceId)
        
        self.videoId = try resourceContainer.decode(String.self, forKey: .videoId)
        
        
    }
    
}
