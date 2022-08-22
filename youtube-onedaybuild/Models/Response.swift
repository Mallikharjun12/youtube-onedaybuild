//
//  Response.swift
//  youtube-onedaybuild
//
//  Created by admin on 21/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import Foundation

struct Response: Decodable {
    
    var items = [Video]()
    
    enum CodingKeys: String,CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([Video].self, forKey: .items)
    }
}
