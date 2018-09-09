//
//  SearchResultsTableViewCell.swift
//  DMCard
//
//  Created by Venkatesh on 09/09/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            self.backgroundColor = UIColor(red: 86/255, green: 137/255, blue: 23/255, alpha: 1.0)
            self.searchResultLabel.textColor = .white
    }
    
}
