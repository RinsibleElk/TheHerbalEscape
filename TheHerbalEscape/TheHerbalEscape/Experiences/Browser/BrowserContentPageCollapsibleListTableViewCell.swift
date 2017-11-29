//
//  BrowserContentPageCollapsibleListTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 28/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageCollapsibleListTableViewCell: UITableViewCell, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var contentListTableView: UITableView!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        contentListTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
