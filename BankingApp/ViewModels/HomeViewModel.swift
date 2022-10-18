//
//  HomeViewModel.swift
//  My Budget Tracker
//
//  Created by Macbook on 24/09/2022.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel: NSObject {
    
    //property to get the data when success
    var usersFromCoreData: [NSManagedObject] = []
    let manageContext: NSManagedObjectContext
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.manageContext = mainContext
    }
      func addUsersToCoreData(){
        for user in TempDataBase().usersArray{
            callFuncToAddUsersToCoreData(user: user)
        }
    }
     private  func callFuncToAddUsersToCoreData(user:User){
        
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: manageContext)
        let CoreDataUser = NSManagedObject(entity: entity!, insertInto: manageContext)

         CoreDataUser.setValue(user.userId, forKey: "id")
         CoreDataUser.setValue(user.name, forKey: "name")
         CoreDataUser.setValue(user.phone, forKey: "phone")
         CoreDataUser.setValue(user.email, forKey: "email")
         CoreDataUser.setValue(user.balance, forKey: "balance")
        
        let image = user.image
        let pngImageData  = image.pngData()
         CoreDataUser.setValue(pngImageData, forKey: "image")
                
        do{
            try manageContext.save()
                usersFromCoreData.append(CoreDataUser)
        }catch let error{
            print(error)
        }
    }
    
    func callFuncToFetchUsersFromCoreData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        
        do{
            usersFromCoreData = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
    }
    func updateUserBalance(userId:String,amount:Double){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        let predicate = NSPredicate(format: "id == %@", userId)
        fetchRequest.predicate = predicate
        
        var newBalance:Double?
        
        if let result = try? manageContext.fetch(fetchRequest) {
            for CoreDataUser in result {
                if let oldBalance = CoreDataUser.value(forKey: "balance") as? Double{
                    newBalance = oldBalance + amount
                }
                 CoreDataUser.setValue(newBalance, forKey: "balance")
                try? manageContext.save()
            }
        }
    }
    func getUserProfileViewModel(for index: Int) -> UserProfileViewModel {
        return UserProfileViewModel(user: usersFromCoreData[index])
    }
}
