//
//  RegesterVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/11/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class RegesterVC: UIViewController  , NVActivityIndicatorViewable{
    //MARK: - var
    
    var register:Register?
    var failure:Failure?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var passwrod: DesignableUITextField!
    @IBOutlet weak var phone: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var regesterBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - IBAction
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        getregister()
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Func Register
    
    func getregister(){
        self.startAnimating()
        if let name = name.text ,let mail = email.text , let phone = phone.text , let pass = passwrod.text {
            if  name.count  >= 4 {
                print("cvbnm,")
                APIClient.register(user_name: name , mail: mail, phone: phone, pass: pass){(Result) in
                    switch Result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            print("aaaaaaaa")
                            print(response)
                            self.register = response
                            Alert.show("Error", massege: self.register!.message, context: self)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            print("bbbbbbbbb")
                            print(error.localizedDescription)
                            APIClient.registerfailure(user_name: name , mail: mail, phone: phone, pass: pass) {(Result) in
                                switch Result {
                                case .success(let response):
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        print("aaaaaaaa")
                                        print(response)
                                        self.failure = response
                                        Alert.show("Error", massege: self.failure!.message, context: self)
                                    }
                                case .failure(let error):
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        print("bbbbbbbbb")
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                }
            }else {
                Alert.show("Error", massege: "الاسم يجب ان يكون اربع حروف علي الاقل", context: self)
            }
            
            
        }
    }
    
    
    
    
    
    
    
    
}
