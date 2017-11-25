//
//  PhotosViewController.swift
//  Tumblr_Feed
//
//  Created by Jungyoon Yu on 11/11/17.
//  Copyright © 2017 Jungyoon Yu. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            
            cell.photoImageView.af_setImage(withURL: url!)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270;
    }
    
    var posts: [[String:Any]] = []
    
    @IBOutlet weak var tumblrTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tumblrTableView.delegate = self
        tumblrTableView.dataSource = self
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]                // TODO: Reload the table view
                self.tumblrTableView.reloadData()
            }
        }
        
        task.resume()    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cs = segue.destination as! PhotosDetailViewController
        let cell = sender as! UITableViewCell
        if let indexPath = tumblrTableView.indexPath(for: cell) {
            let post = posts[(indexPath.row)]
            
            //let post = posts[indexPath?.row]
            if let photos = post["photos"] as? [[String: Any]] {
                // photos is NOT nil, we can use it!
                // TODO: Get the photo url
                // 1.
                let photo = photos[0]
                // 2.
                let originalSize = photo["original_size"] as! [String: Any]
                // 3.
                let urlString = originalSize["url"] as! String
                // 4.
                let url = URL(string: urlString)
            
                //cell.photoImageView.af_setImage(withURL: url!)
                cs.photoURL = url
                
            }
        }
        
    
    }
    

}
