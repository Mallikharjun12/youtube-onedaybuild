//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by admin on 21/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate ,ModelDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //set itself as the delegate of the model
        model.delegate = self
      
        model.getVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Confirm that a video was selected
        guard tableView.indexPathForSelectedRow != nil else {return}
        
        //Get a reference to the video that was tapped on
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        //Get a refernce to the DetailViewController
        let detailVC = segue.destination as! DetailViewController
        
        //Set the Video property of the detail viewcontroller
        detailVC.video = selectedVideo
    }
    
    //MARK: - Model Delegate methods
    
    func videosFetched(_ videos: [Video]) {
        
        //set the returned videos to our video property
        self.videos = videos
        
        //Refresh the tableView
        tableView.reloadData()
    }

    
     //MARK: - TableView methods
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
      }
  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        
        // Configure the cell with the data
        
        let video = videos[indexPath.row]
        
        cell.setCell(video)
        return cell
     }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       }
  
}

