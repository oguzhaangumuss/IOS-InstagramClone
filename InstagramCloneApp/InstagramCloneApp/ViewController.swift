//
//  ViewController.swift
//  InstagramCloneApp
//
//  Created by Oğuzhan Gümüş on 1.12.2023.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messeageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error!", messeageInput: "Username or password is empty!")
        }
        
    }
    @IBAction func  signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Erorr!", messeageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
              makeAlert(titleInput: "Error!", messeageInput: "Username/Password?")
            }
        }
    func makeAlert(titleInput:String,messeageInput:String){
        let alert = UIAlertController(title: titleInput, message: messeageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    }//Class














/* Firebase codes
 import UIKit
 import FirebaseCore


 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

   func application(_ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions:
       [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()

     return true
   }
 }
 */
