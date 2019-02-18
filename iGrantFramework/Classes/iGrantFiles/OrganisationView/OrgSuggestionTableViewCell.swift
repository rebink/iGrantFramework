//
//  OrgSuggestionTableViewCell.swift
//  iGrant
//
//  Created by Ajeesh T S on 27/03/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit

protocol OrganisationSuggestionCellDelegate: class {
    func selectedOrganisation(organisation:Organization?)
}

class OrgSuggestionTableViewCell: UITableViewCell {
    weak var delegate: OrganisationSuggestionCellDelegate?
    var organisationList : [Organization]?
    @IBOutlet weak var orgCollectionView: UICollectionView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(){
    
    }

}

extension OrgSuggestionTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if self.organisationList != nil{
            return (self.organisationList?.count)!
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = UIScreen.main.bounds.size.width - 45
        return CGSize(width: viewSize, height: 300) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionCell", for: indexPath as IndexPath) as! OrgSuggestionCollectionViewCell
        cell.organisation = self.organisationList?[indexPath.row]
        cell.showData()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        self.delegate?.selectedOrganisation(organisation: self.organisationList?[indexPath.row])
    }
    
    
}
