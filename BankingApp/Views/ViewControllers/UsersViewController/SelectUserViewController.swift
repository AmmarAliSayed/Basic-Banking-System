//
//  UsersViewController.swift
//  BankingApp
//
//  Created by Macbook on 14/10/2022.
//

import UIKit
import CoreData
class SelectUserViewController: UIViewController {
    //MARK: - Vars
        var tempArray: [NSManagedObject] = []
        var homeViewModel : HomeViewModel?
        var transactionViewModel :TransactionViewModel?
        var sender : String?
        var senderId: String?
        var amount : Double?
        var status : String?
       //MARK: - IBOutlets
       @IBOutlet weak var tableView: UITableView!{
           didSet{
               tableView.delegate = self
               tableView.dataSource = self
               //add register
               tableView.register(UINib(nibName: CellsIDs.userTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: UserTableViewCell.self))
           }
       }
       //MARK: - View Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()
             homeViewModel = HomeViewModel()
           transactionViewModel = TransactionViewModel()
            // homeViewModel?.addTransactionsToCoreData()
             homeViewModel?.callFuncToFetchUsersFromCoreData()
           if let users = homeViewModel?.usersFromCoreData{
               tempArray = users
           }
             tableView.reloadData()
          
       }
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
          // print("AAAA\(sender)")
       }
       //MARK: - IBActions
       
       
       
   //MARK: - Helper Fuctions
     
   }
   extension SelectUserViewController : UITableViewDelegate, UITableViewDataSource{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // let transactionsNum = homeViewModel?.transactionsFromCoreData.count
         print("DEBUG:\(tempArray.count)")
          // return transactionsNum ?? 0
           return tempArray.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: CellsIDs.userTableViewCell, for: indexPath) as! UserTableViewCell
          // cell.budgetNameLabel?.text = "mmmmmmm"
          // let budget = TempDataBase().expenses_arr[indexPath.row]
         //let budget = tempArray[indexPath.row]
            let user  = tempArray[indexPath.row]
            cell.setupCell(user: user)
         //  cell.setupCell(transaction: budget)
           return cell
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           let user  = tempArray[indexPath.row]
           if  let receiver = user.value(forKey: "name") as? String ,let receiverId = user.value(forKey: "id") as? String, let am = amount, let sen = sender ,let st = status,let id = senderId {
               
             //  print("the receiver is:\(receiver)")
              let transaction = Transaction(_sender: sen, _receiver: receiver, _amount: am, _status: st)
               transactionViewModel?.callFuncToAddTransactionsToCoreData(transaction: transaction)
               homeViewModel?.updateUserBalance(userId: receiverId, amount: am)
               homeViewModel?.updateUserBalance(userId: id, amount: -am)
               //self.showToast(message:"Successful Transaction!", color: #colorLiteral(red: 0, green: 0.4039215686, blue: 0.6941176471, alpha: 1))
               //print("_amount is \(transaction.amount)")
              // print("_status is \(transaction.status)")
           }
           self.navigationController?.popToRootViewController(animated: true)
       }
   }
