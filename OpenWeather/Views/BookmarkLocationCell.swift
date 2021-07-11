//
//  BookmarkLocationCell.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import UIKit

protocol BookmarkLocationCellDelegate: AnyObject {
    func deleteBookmark(at cell: BookmarkLocationCell)
}
class BookmarkLocationCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var deleteLocationButton: UIButton!
    
    //MARK: - Variables
    weak var delegate: BookmarkLocationCellDelegate?
    
    //MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ location: Location) {
        locationNameLabel.text = location.name
    }
    
    //MARK: - Action
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteBookmark(at: self)
    }    
}
