//
//  TempDataBase.swift
//  My Budget Tracker
//
//  Created by Macbook on 15/09/2022.
//

import Foundation
import UIKit
class TempDataBase{
    
   var usersArray: [User] = []
    
    
    init(){
        addUsers()
    }
    
    func addUsers(){
        
        guard let user_1_Image = UIImage(named: "1") else{
            return
        }
        guard let user_2_Image = UIImage(named: "2") else{
            return
        }
        guard let user_3_Image = UIImage(named: "3") else{
            return
        }
        guard let user_4_Image = UIImage(named: "4") else{
            return
        }
        guard let user_5_Image = UIImage(named: "5") else{
            return
        }
        guard let user_6_Image = UIImage(named: "6") else{
            return
        }
        guard let user_7_Image = UIImage(named: "7") else{
            return
        }
        guard let user_8_Image = UIImage(named: "8") else{
            return
        }
        guard let user_9_Image = UIImage(named: "9") else{
            return
        }
        guard let user_10_Image = UIImage(named: "10") else{
            return
        }

        let user_1 = User(_name: "Ahmed", _email: "Ahmed@gmail.com", _balance: 20.0, _image: user_1_Image, _phone: "0477777777")
        let user_2 = User(_name: "Mohamed", _email: "Mohamed@gmail.com", _balance: 10.0, _image: user_2_Image, _phone: "0477777777")
        let user_3 = User(_name: "Ibrahim", _email: "Ibrahim@gmail.com", _balance: 30.0, _image: user_3_Image, _phone: "0477777777")
        let user_4 = User(_name: "Noha", _email: "Noha@gmail.com", _balance: 40.0, _image: user_4_Image, _phone: "0477777777")
        let user_5 = User(_name: "Soha", _email: "Soha@gmail.com", _balance: 50.0, _image: user_5_Image, _phone: "0477777777")
        let user_6 = User(_name: "Nagwa", _email: "Nagwa@gmail.com", _balance: 60.0, _image: user_6_Image, _phone: "0477777777")
        let user_7 = User(_name: "Hassan", _email: "Hassan@gmail.com", _balance: 70.0, _image: user_7_Image, _phone: "0477777777")
        let user_8 = User(_name: "Hossam", _email: "Hossam@gmail.com", _balance: 80.0, _image: user_8_Image, _phone: "0477777777")
        let user_9 = User(_name: "Shady", _email: "Shady@gmail.com", _balance: 90.0, _image: user_9_Image, _phone: "0477777777")
        let user_10 = User(_name: "Amr", _email: "Amr@gmail.com", _balance: 100.0, _image: user_10_Image, _phone: "0477777777")
        usersArray.append(user_1)
        usersArray.append(user_2)
        usersArray.append(user_3)
        usersArray.append(user_4)
        usersArray.append(user_5)
        usersArray.append(user_6)
        usersArray.append(user_7)
        usersArray.append(user_8)
        usersArray.append(user_9)
        usersArray.append(user_10)

        
    }
}
