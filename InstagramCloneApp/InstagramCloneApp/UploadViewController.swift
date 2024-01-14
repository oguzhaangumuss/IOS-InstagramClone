//
//  UploadViewController.swift
//  InstagramCloneApp
//
//  Created by Oğuzhan Gümüş on 2.12.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
     }
    func makeAlert(titleInput: String, messeageInput: String){
        let alert = UIAlertController(title: titleInput, message: messeageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        self.present(alert, animated: true)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        //Upload image to storage
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data) { metedata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Erorr!", messeageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference!
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!,"postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection(  "Posts").addDocument(data: firestorePost,completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messeageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "gorsel")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            })
                        }
                    }
                }
            }
            
        }
        
        
    }
    
}
