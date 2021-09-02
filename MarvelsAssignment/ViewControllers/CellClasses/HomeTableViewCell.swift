//
//  HomeTableViewCell.swift
//  MarvelsAssignment
//
//  Created by Ankur on 26/08/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCharacter.layer.cornerRadius = 10
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.borderWidth = 1
        viewBackground.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
