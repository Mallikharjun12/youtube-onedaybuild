//
//  CacheManager.swift
//  youtube-onedaybuild
//
//  Created by admin on 22/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    static func setVideocache(_ url: String,_ data: Data?) {
        
        //store the image data and use the url as the key
        cache[url] = data
        
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        //Try to get the data for the specified url
        return cache[url]
    }
    
}
