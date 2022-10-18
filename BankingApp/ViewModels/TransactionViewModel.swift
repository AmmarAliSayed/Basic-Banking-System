//
//  TransactionViewModel.swift
//  BankingApp
//
//  Created by Macbook on 15/10/2022.
//

import CoreData

class TransactionViewModel: NSObject {
    
    //property to get the data when success
    var transactionsFromCoreData: [NSManagedObject] = []
    let manageContext: NSManagedObjectContext
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.manageContext = mainContext
    }
     
       func callFuncToAddTransactionsToCoreData(transaction:Transaction){
        
        let entity = NSEntityDescription.entity(forEntityName: "TransactionEntity", in: manageContext)
        let CoreDataUser = NSManagedObject(entity: entity!, insertInto: manageContext)

         CoreDataUser.setValue(transaction.sender, forKey: "sender")
         CoreDataUser.setValue(transaction.receiver, forKey: "receiver")
         CoreDataUser.setValue(transaction.amount, forKey: "amount")
         CoreDataUser.setValue(transaction.date, forKey: "date")
         CoreDataUser.setValue(transaction.status, forKey: "status")
    
        do{
            try manageContext.save()
            transactionsFromCoreData.append(CoreDataUser)
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
