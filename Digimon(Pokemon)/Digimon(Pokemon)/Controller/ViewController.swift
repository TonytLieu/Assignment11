//
//  ViewController.swift
//  Digimon(Pokemon)
/*
 1.
 For existing app In Login Screen App add login validation function
 2.Show the use of alert controller

 2.
 Create a New App for Pokemon in UI Kit covering the below screens. Follow MVC architecture
 Use this API= https://digimon-api.vercel.app/api/digimon
 Screen 1- Tabelview- Tabelview usage, call the above api and show few data in cell
 P

 2.Screen 2 Detail Screen- On tableview Cell click, Take the same obj from table view and show all its details here using,  labels or any other UI Component

 3.Create Network manager to use Closures to fetch data API from Network Layer to show on UI., use generics to for Network manager function
 */
//  Created by Tony Lieu on 11/2/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var passwordID: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        //this will check if the username and password is right
        if loginVal(emailID: userName.text, passwordinput: passwordID.text){
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               //this makes so i can pass data to the tableViewScence
               let listVC = storyBoard.instantiateViewController(withIdentifier: "PokemonTableViewController") as! PokemonTableViewController
               self.navigationController?.pushViewController(listVC, animated: true)
               print("login Button tapped")
               
        }else{
            print("You are not allowed")
            let alertViewController =  UIAlertController(title: "WP/U", message: "incorrect password or username", preferredStyle: .actionSheet)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alertViewController, animated: true)
        }
   
    }
    func loginVal(emailID:String?, passwordinput:String?)-> Bool{
        var isValid = false
        guard let emailID = emailID else{
            return isValid
        }
        guard let passwordinput = passwordinput else{
            return isValid
        }
        let isValidPassword = passwordinput.count >= 6
        let emailRegex = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        //                  abc           @ gmail          .com
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid =  emailPredicate.evaluate(with: emailID)
        isValid = isEmailValid && isValidPassword
        return isValid
    }
    
    }
