//
//  TransactionsHistoryViewController.swift
//  BankingApp
//
//  Created by Macbook on 15/10/2022.
//

import UIKit
import CoreData
class TransactionsHistoryViewController: UIViewController {
    //MARK: - Vars
        var tempArray: [NSManagedObject] = []
        var transactionViewModel :TransactionViewModel?
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            //add register
            tableView.register(UINib(nibName: CellsIDs.transactionTableViewCell, bundle: nil), forCellReuseIdentifier: String(describing: TransactionTableViewCell.self))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionViewModel = TransactionViewModel()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        transactionViewModel?.callFuncToFetchTransactionsFromCoreData()
      if let transactions = transactionViewModel?.transactionsFromCoreData{
          tempArray = transactions
      }
        tableView.reloadData()
    }

}
extension TransactionsHistoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let transactionsNum = homeViewModel?.transactionsFromCoreData.count
      print("DEBUG:\(tempArray.count)")
       // return transactionsNum ?? 0
        return tempArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsIDs.transactionTableViewCell, for: indexPath) as! TransactionTableViewCell
       // cell.budgetNameLabel?.text = "mmmmmmm"
       // let budget = TempDataBase().expenses_arr[indexPath.row]
      //let budget = tempArray[indexPath.row]
         let transaction  = tempArray[indexPath.row]
         cell.setupCell(transaction: transaction)
      //  cell.setupCell(transaction: budget)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
}
