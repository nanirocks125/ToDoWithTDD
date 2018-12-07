//
//  ItemTableViewCell.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCellWithItem(item: ToDoItem, checked: Bool = false) {
        if checked {
            let attributedTitle = NSAttributedString(string: item.title,
                                                     attributes: [NSAttributedString.Key.strikethroughStyle:
                    NSUnderlineStyle.single.rawValue])
            
            titleLabel.attributedText = attributedTitle
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name
            
            if let timestamp = item.timeStamp {
                let date = Date(timeIntervalSince1970: timestamp)
                
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
}
