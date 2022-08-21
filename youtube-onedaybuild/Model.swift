//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by admin on 21/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(_ videos: [Video])
    
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos()  {
        
        // Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {return}
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a datatask from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check if there is any error
            
            if error != nil || data == nil {
                print("Error is there")
            }
            
            do {
                
                //Parsing the data into video objects
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil {
                    
                    DispatchQueue.main.async {
                        
                        //call the videosfetched method of the delegate
                        self.delegate?.videosFetched(response.items)
                    }
                    
                }
                dump(response)
            }
            catch {
                
            }
            
        }
        
        //kick off the task
        dataTask.resume()
        
        
    }
    
}
