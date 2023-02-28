//
//  MateriasTableViewCell.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 23/02/23.
//

import UIKit
import SwipeCellKit

class MateriasTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var ContenedorView: UIView!
    @IBOutlet weak var IdMaterialbl: UILabel!
    
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Costolbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
