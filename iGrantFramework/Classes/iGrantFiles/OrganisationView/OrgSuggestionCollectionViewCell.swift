//
//  OrgSuggestionCollectionViewCell.swift
//  iGrant
//
//  Created by Ajeesh T S on 27/03/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit

class OrgSuggestionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var orgImageView: UIImageView!
    var organisation : Organization?
    
    override func awakeFromNib() {
        orgImageView.layer.cornerRadius = 10.0
    }
    
    func showData(){
        if let imageUrl = organisation?.imageURL{
            orgImageView.kf.setImage(with: imageUrl)
        }
        nameLbl.text = organisation?.name
        var orgType = ""
        var orgLocation = " "
        
        if self.organisation?.type.type != nil{
            orgType = (self.organisation?.type.type)!
        }
        if self.organisation?.location != nil{
            orgLocation = (self.organisation?.location)!
        }
        locationLbl.attributedText = Utilitymethods.showBlueAndBackColorText(blackColorWord:  orgLocation, blueColorWord:  orgType)
    }
}
