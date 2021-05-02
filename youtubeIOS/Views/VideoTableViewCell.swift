//
//  VideoTableViewCell.swift
//  youtubeIOS
//
//  Created by niab on May/02/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
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
        
        
        guard self.video != nil else {
            return
        }
        
        // Set the title and date label
        self.titleLabel.text = video?.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the image thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        
        
        // Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        // Get the shared URL Session object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error)
            in
            
            if error == nil && data != nil {
                // Save the data in cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                
                // Check that downloaded url matches the video thumbnail url
                
                
                if url!.absoluteString != self.video?.thumbnail {
                    
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the imageview
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
            
        }
        // Start data task
        dataTask.resume()
        
    }
    
}
