//
//  UserTableViewCell.swift
//  BankingApp
//
//  Created by Macbook on 10/10/2022.
//

import UIKit
import CoreData
class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBalanceLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        //  contentView.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1176470588, blue: 0.1450980392, alpha: 1)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.6941176471, alpha: 1)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.size.width / 30
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //space between cells in table view
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    func setupCell(user :NSManagedObject ) {
        if  let name = user.value(forKey: "name") as? String{
            userNameLabel.text = name
        }
        if let amount = user.value(forKey: "balance") as? Double{
            userBalanceLabel.text = "\(amount)"
        }
        // budgetIconImageView.image = UIImage(named: transaction.image)
        //let image = UIImage(data: transaction.value(forKey: "image") as! Data)
        //budgetIconImageView.image = image
        
        
        let storedImageData = user.value(forKey: "image") as? Data
        if let imageData = storedImageData {
            let image = UIImage(data: imageData)
            userImageView.image = image
        }
    }
        
}
