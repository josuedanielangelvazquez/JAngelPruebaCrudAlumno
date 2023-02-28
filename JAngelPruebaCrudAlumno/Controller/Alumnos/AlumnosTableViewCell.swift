//
//  AlumnosTableViewCell.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 22/02/23.
//

import UIKit
import SwipeCellKit
class AlumnosTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var IdAlumno: UILabel!
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var ApellidoPaternolbl: UILabel!
    @IBOutlet weak var ApellidoMaternolbl: UILabel!
    @IBOutlet weak var FechaNacimientolbl: UILabel!
    @IBOutlet weak var Generolbl: UILabel!
    
    @IBOutlet weak var Telefonolbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
