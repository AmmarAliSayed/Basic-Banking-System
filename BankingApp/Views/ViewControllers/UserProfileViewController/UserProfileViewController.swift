//
//  UserProfileViewController.swift
//  BankingApp
//
//  Created by Macbook on 11/10/2022.
//

import UIKit
import CoreData
class UserProfileViewController: UIViewController{
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    //MARK: - Vars
    // let pickerView = UIPickerView()
    //var UserTextField : UITextField?
    // let toolBar = UIToolbar()
    var userProfileViewModel : UserProfileViewModel!
    var transactionViewModel :TransactionViewModel?
    var senderName:String?
    var status:String?
    var amount:Double?
    var id:String?
    // var arr = ["dff","bbb","gg"]
    //  var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionViewModel = TransactionViewModel()
        // let user = userProfileViewModel.selectedUser
        //  if  let name = user?.value(forKey: "name") as? String{
        //   print("DUBUG:THE SELECTED USER NAME IS :\(name)")  }
        guard let user = userProfileViewModel.selectedUser else { return }
        addUserDetails(user: user)
        //  pickerView.delegate = self
        //  pickerView.dataSource = self
        
        
        // toolBar.sizeToFit()
        //  let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePicker))
        //  toolBar.setItems([doneButton], animated: true)
    }
    //MARK: - IBActions
    @IBAction func transferMoneyButtonPressed(_ sender: Any) {
        showAlert()
    }
    //    @objc func closePicker (){
    //        UserTextField?.text = arr [currentIndex]
    //        view.endEditing(true)
    //    }
    //MARK: - Helper Functions
    func addUserDetails(user :NSManagedObject ) {
        if  let name = user.value(forKey: "name") as? String{
            nameLabel.text = name
            senderName = name
        }
        if  let uId = user.value(forKey: "id") as? String{
            id = uId
        }
        if let balance = user.value(forKey: "balance") as? Double{
            balanceLabel.text = "\(balance)"
        }
        if  let phone = user.value(forKey: "phone") as? String{
            phoneLabel.text = phone
        }
        if  let email = user.value(forKey: "email") as? String{
            emailLabel.text = email
        }
        let storedImageData = user.value(forKey: "image") as? Data
        if let imageData = storedImageData {
            let image = UIImage(data: imageData)
            userImageView.image = image
        }
    }
    func showAlert() {
        
        let alertController = UIAlertController(title: "Money Transfer", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Amount"
            textField.keyboardType = .numberPad
            //self.UserTextField = textField
            //UserTextField.delegate = self //REQUIRED
        }
        //        alertController.addTextField { [self] (textField) in
        //            textField.placeholder = "Select User"
        //            textField.inputView = pickerView
        //            textField.inputAccessoryView = toolBar
        //        }
        // index_1 for SelectUser textField
        // UserTextField = alertController.textFields![1] as UITextField
        
        let sendAction = UIAlertAction(title: "Send",
                                       style: .default) { [weak alertController] _ in
            guard let textFields = alertController?.textFields else { return }
            guard let amountText =  textFields[0].text else { return }
            if !amountText.isEmpty {
                //  let userText = textFields[1].text {
              // print("amount: \(amountText)")
                self.amount = Double(amountText)
                self.status = "Success"
                self.performSegue(withIdentifier: "ProfileToSelectUsersSegue", sender: self)
            }else{
                self.showToast(message:"Add amount first!",color: #colorLiteral(red: 0.7647058824, green: 0.003921568627, blue: 0.003921568627, alpha: 1))
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [self] (action) in
            // ...
            self.amount = Double("0.0")
            if let  sender = senderName ,let am = amount{
                let transaction = Transaction(_sender: sender, _receiver: "Not Selected", _amount: am, _status: "Failed")
                 transactionViewModel?.callFuncToAddTransactionsToCoreData(transaction: transaction)
            }
          //  self.performSegue(withIdentifier: "ProfileToSelectUsersSegue", sender: self)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("nnnnnnnnnnnnn")
        let vc = segue.destination as! SelectUserViewController
        vc.sender = senderName
        vc.senderId = id
        vc.status = status
        vc.amount = amount
       }
}
//extension UserProfileViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return arr.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return arr[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        currentIndex = row
//        UserTextField?.text = arr[row]
//    }
//}
//extension UserProfileViewController : UITextFieldDelegate{
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//}
