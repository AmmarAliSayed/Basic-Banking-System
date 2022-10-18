//
//  Income.swift
//  My Budget Tracker
//
//  Created by Macbook on 14/09/2022.
//

import Foundation
import UIKit
struct User{
    var userId :String
    var name: String
    var phone:String
    var email:String
    var balance : Double
    var image :UIImage
    init(_name :String,_email:String ,_balance: Double,_image:UIImage, _phone :String) {
        //create random id
        userId = UUID().uuidString
        name = _name
        balance = _balance
        image = _image
        phone = _phone
        email = _email
    }
   
}
