//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by admin on 21/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
    func setCell(_ v:Video) {
        
        self.video = v
        
        //Ensure that we have a video
        guard self.video != nil else {return}
        
        //set the title
        titleLabel.text = video?.title
        
        //set the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE,MMM d,yyyy"
        dateLabel.text = dateFormatter.string(from: video!.published)
        
        //set the thumbnail
        guard self.video!.thumbnail != "" else {return}
        
        //check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(video!.thumbnail) {
            
            //set the thumbnail imageView
            thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        //Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //Get the shared URL session object
        let session = URLSession.shared
        
        //Create a dataTask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                //save the data in cache
                CacheManager.setVideocache(url!.absoluteString, data)
                
                //check the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url?.absoluteString != self.video?.thumbnail {
                    
                    //Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                
                //Create the image object
                let image = UIImage(data: data!)
                
                //Set the imageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        //start data task
        dataTask.resume()
    }
}
