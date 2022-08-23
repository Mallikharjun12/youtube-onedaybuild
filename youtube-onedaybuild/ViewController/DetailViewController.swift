//
//  DetailViewController.swift
//  youtube-onedaybuild
//
//  Created by admin on 22/08/22.
//  Copyright © 2022 konda. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textView: UITextView!
    
    var video: Video?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Clear the fields
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        
        
        //check if there is a video
        guard video != nil else {return}
        
        //Create the embed URL
        let embedURLString = Constants.YT_EMBED_URL + video!.videoId
        
        //Load it into the webview
        let url = URL(string: embedURLString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        //Set the title
        titleLabel.text = video!.title
        
        //Set the date
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE,MMM d,yyyy"
        dateLabel.text = dateFormatter.string(from: video!.published)
        
        //Set the description
        textView.text = video!.description
    }

    
}
