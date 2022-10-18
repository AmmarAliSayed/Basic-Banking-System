//
//  TransactionTableViewCell.swift
//  BankingApp
//
//  Created by Macbook on 15/10/2022.
//

import UIKit
import CoreData
class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //  contentView.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1176470588, blue: 0.1450980392, alpha: 1)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.6941176471, alpha: 1)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.size.width / 30
    }
    //space between cells in table view
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(transaction :NSManagedObject ) {
        if  let sender = transaction.value(forKey: "sender") as? String{
            senderLabel.text = sender
        }
        if  let receiver = transaction.value(forKey: "receiver") as? String{
            receiverLabel.text = receiver
        }
        if  let status = transaction.value(forKey: "status") as? String{
            statusLabel.text = status
            if status == "Failed"{
                statusLabel.textColor = #colorLiteral(red: 0.7647058824, green: 0.003921568627, blue: 0.003921568627, alpha: 1)
            }
        }
        if let amount = transaction.value(forKey: "amount") as? Double{
            amountLabel.text = "\(amount)"
        }
        if let date = transaction.value(forKey: "date") as? Date{
            dateLabel.text = "\(date)"
        }
    }
}
