//
//  ItemCell.swift
//  MyDreamLister
//
//  Created by Younoussa Ousmane Abdou on 1/20/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet private var thumbIMB: UIImageView!
    @IBOutlet private var titleLBL: UILabel!
    @IBOutlet private var priceLBL: UILabel!
    @IBOutlet private var detailLBL: UILabel!
    
    func configureCell(item: Item) {
        
        thumbIMB.image = item.toImage?.image as? UIImage
        titleLBL.text = item.title
        priceLBL.text = "$\(item.price)" 
        detailLBL.text = item.details
    }
}
