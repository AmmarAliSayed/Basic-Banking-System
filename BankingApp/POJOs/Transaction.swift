//
//  Transaction.swift
//  BankingApp
//
//  Created by Macbook on 14/10/2022.
//

import Foundation
struct Transaction{
    var sender :String
    var receiver: String
    var amount : Double
    var date :Date
    var status :String
    init(_sender :String,_receiver:String ,_amount: Double,_status:String) {
        date = Date()
        sender = _sender
        receiver = _receiver
        amount = _amount
        status = _status
    }
}
