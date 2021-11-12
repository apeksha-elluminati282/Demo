//
//  SignInVC.swift
//  ProgrammaticConstraintDemo
//
//  Created by MacPro3 on 09/11/21.
//

import UIKit
import Firebase
import GoogleSignIn


class SignInVC: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnSignIn: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickBtnLogin(_ sender: UIButton) {
        Auth.auth().signInAnonymously()

    }
    
    @IBAction func onClickBtnGoogleSignIn(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            if user != nil
            {
                ph.set(user?.userID ?? "", forKey: "userId")
                ph.synchronize()
                let credential = GoogleAuthProvider.credential(withIDToken: user?.authentication.idToken ?? "", accessToken: user?.authentication.accessToken ?? "")
                Auth.auth().signIn(with: credential) { (user, error) in
                    if  let error = error{
                        print("Error == > \(error)")
                        return
                    }
                }
            }
            
            // If sign in succeeded, display the app's main content View.
          }
    }
  
}
