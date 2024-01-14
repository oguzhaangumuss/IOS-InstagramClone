//
//  FeedCell.swift
//  InstagramCloneApp
//
//  Created by Oğuzhan Gümüş on 13.01.2024.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let firebaseDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["likes" : likeCount + 1 ] as [String : Any]
        
        firebaseDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
        
    }
    
}
