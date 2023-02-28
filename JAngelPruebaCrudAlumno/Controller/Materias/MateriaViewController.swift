//
//  MateriaViewController.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 23/02/23.
//

import UIKit

class MateriaViewController: UIViewController {
    let materiaviewmodel = MateriasViewModel()
    var materia : Materia? = nil
    var IdMateria = 0
    var segues = ""
    
    @IBOutlet weak var Agregarmod: UIButton!
    
    @IBOutlet weak var Actualizarmod: UIButton!
    
    @IBOutlet weak var IdMaterialbl: UITextField!
    @IBOutlet weak var Nombrelbl: UITextField!
    @IBOutlet weak var Costolbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    validacion()
    }
    
    func validacion(){
        if segues == "UpdateSeguesMateria"{
            Agregarmod.isHidden = true
            IdMaterialbl.isHidden = true
            materiaviewmodel.GetById(IdMateria: IdMateria) { [self] ObjectMateria in
                DispatchQueue.main.async { [self] in
                    if ObjectMateria != nil{
                        materia = ObjectMateria.Object
                        IdMaterialbl.text = String(materia!.IdMateria)
                        Nombrelbl.text = materia?.Nombre
                        Costolbl.text = String(materia!.Costo)
                    }
                    else{
                        IdMaterialbl.isHidden = true
                        Actualizarmod.isHidden = true
                        let alert = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                        
                    }

                }
                
            }
        }
        else{
            Actualizarmod.isHidden = true
        }
    }
    
    @IBAction func EnviarAction(_ sender: Any) {
       
        let Nombre = Nombrelbl.text
        let Costo2 = Costolbl.text
        
        materia = Materia(IdMateria: 0, Nombre: Nombre!, Costo: Float(Costo2!)!)
        materiaviewmodel.PostMateria(materia: materia!) { resultado in
            DispatchQueue.main.async {
                
                if resultado.Correct == true{
                    let alert = UIAlertController(title: "Correcto", message: "Se agrego la materia correctamente", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
                
            }
        }
        
    }
    
    
    @IBAction func ActualizarAction(_ sender: Any) {
        let Nombre = Nombrelbl.text
        let Costo2 = Costolbl.text
        materia = Materia(IdMateria: 0, Nombre: Nombre!, Costo: Float(Costo2!)!)
        materiaviewmodel.PostUpdate(materia: materia!, IdMateria: IdMateria) { ObjectMateria in
            DispatchQueue.main.async { [self] in
                if ObjectMateria.Correct == true{
                  var alertcorrect = UIAlertController(title: "Correcto", message: "Se Modifico Correctamente", preferredStyle: .alert)
                    alertcorrect.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertcorrect, animated: true)
                  
                }
                else{
                    var alertError = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                    alertError.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertError, animated: true)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
