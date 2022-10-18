//
//  UserProfileViewModel.swift
//  BankingApp
//
//  Created by Macbook on 11/10/2022.
//

import Foundation
import CoreData
import UIKit

class UserProfileViewModel: NSObject {
    
    //property to get the data when success
    var selectedUser: NSManagedObject?
    var transactionsFromCoreData: [NSManagedObject] = []
    let manageContext: NSManagedObjectContext
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext,user:NSManagedObject) {
        self.manageContext = mainContext
        selectedUser = user
    }
    
    func createNewTransaction(transaction:Transaction){
        let entity = NSEntityDescription.entity(forEntityName: "TransactionEntity", in: manageContext)
        let CoreDataTransaction = NSManagedObject(entity: entity!, insertInto: manageContext)
        
        CoreDataTransaction.setValue(transaction.sender, forKey: "sender")
        CoreDataTransaction.setValue(transaction.receiver, forKey: "receiver")
        CoreDataTransaction.setValue(transaction.status, forKey: "status")
        CoreDataTransaction.setValue(transaction.date, forKey: "date")
        CoreDataTransaction.setValue(transaction.amount, forKey: "amount")
        
        do{
            try manageContext.save()
            transactionsFromCoreData.append(CoreDataTransaction)
        }catch let error{
            print(error)
        }
    }
    
    func callFuncToFetchTransactionsFromCoreData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TransactionEntity")
        
        do{
            transactionsFromCoreData = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
    }
}
