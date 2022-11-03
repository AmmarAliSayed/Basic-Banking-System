//
//  ViewController.swift
//  My Budget Tracker
//
//  Created by Macbook on 11/09/2022.
//

import UIKit
import CoreData
class HomeViewController: UIViewController{
    //MARK: - Vars
    // master array
    //     var selectedIndexPath = IndexPath(item: 0, section: 0)
    var tempArray: [NSManagedObject] = []
    //     var IncomeTempArray: [NSManagedObject] = []
    var homeViewModel : HomeViewModel?
    
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
        //we active this function one time only in the first app launch
        if !isAppAlreadyLaunchedOnce() {
            homeViewModel?.addUsersToCoreData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        homeViewModel?.callFuncToFetchUsersFromCoreData()
        if let users = homeViewModel?.usersFromCoreData{
            tempArray = users
        }
        tableView.reloadData()
    }
    
    //MARK: - Helper Functions
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
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
        print("DEBUG:THE INDEX IS:\(indexPath.row)")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController
        vc?.userProfileViewModel = self.homeViewModel?.getUserProfileViewModel(for: indexPath.row)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
