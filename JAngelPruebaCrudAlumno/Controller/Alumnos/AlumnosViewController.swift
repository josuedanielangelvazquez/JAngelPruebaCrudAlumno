//
//  AlumnosViewController.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 24/02/23.
//

import UIKit

class AlumnosViewController: UIViewController {
    
    @IBOutlet weak var Actulizarmod: UIButton!
    
    @IBOutlet weak var Agregarmod: UIButton!
    
    @IBOutlet weak var Identificadortext: UITextField!
    @IBOutlet weak var Nombretext: UITextField!
    @IBOutlet weak var Apellidopaternotext: UITextField!
    @IBOutlet weak var ApellidoMaternotext: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var Sexo: UISegmentedControl!
    @IBOutlet weak var Telefono: UITextField!
    var alumnosviewmodel = AlumnoViewModel()
    var alumnoadd :Alumno? = nil
    var varSexo = "M"
    var IdAlumno = 0
    var segues = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Sexo.selectedSegmentIndex = 0

       
        Identificadortext.isHidden = true
       loadData()
    }
    
  
    func loadData(){
        if segues == "UpdateSeguesAlumno"{
            Agregarmod.isHidden = true

            alumnosviewmodel.GetByiD(IdAlumno: IdAlumno) { [self] ObjectAlumno in
                DispatchQueue.main.async { [self] in
                    alumnoadd = ObjectAlumno.Object! as Alumno
                    
                    Identificadortext.text = String(alumnoadd!.IdAlumno)
                    Nombretext.text = alumnoadd?.Nombre
                    Apellidopaternotext.text = alumnoadd?.ApellidoPaterno
                    ApellidoMaternotext.text = alumnoadd?.ApellidoPaterno
                    let fecha = alumnoadd?.FechaNacimiento
                    let fechaDate = DateFormatter()
                    fechaDate.dateFormat = "dd/MM/yy"
                    fechaDate.date(from: fecha!)
                    DatePicker.date = fechaDate.date(from: fecha!)!
                    if alumnoadd?.Genero == "F" || alumnoadd?.Genero == "F "{
                        Sexo.selectedSegmentIndex = 1
                    }
                    if alumnoadd?.Genero == "M"{
                        Sexo.selectedSegmentIndex = 0
                    }
                    Telefono.text = alumnoadd?.Telefono
                }
               
                
            }
        }
        else{
            Actulizarmod.isHidden = true
            print("Error ")
        }
    }
    
   
    
    @IBAction func SegmentSexo(_ sender: Any) {
   
        if Sexo.selectedSegmentIndex == 1{
            varSexo = "F"
        }
        else{
            varSexo = "M"
        }
    }
    
    
    @IBAction func EnviarAction(_ sender: Any) {
        
            if Identificadortext.text == "", Nombretext.text == "", Apellidopaternotext.text == "", ApellidoMaternotext.text == "", Telefono.text == "" {
                let alert = UIAlertController(title: "Error", message: "Rellene todos los campos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        else{
            
            let dateFormater: DateFormatter = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            let stringFromDate: String = dateFormater.string(from: self.DatePicker.date) as String
            var nombre = Nombretext.text
            var Apellidopaterno = Apellidopaternotext.text
            var Apellidomaterno = ApellidoMaternotext.text
            var fechanacimiento = stringFromDate
            var telefono = Telefono.text
            
            
            alumnoadd = Alumno(IdAlumno: 0, Nombre: nombre!, ApellidoPaterno: Apellidopaterno!, ApellidoMaterno: Apellidopaterno!, FechaNacimiento: fechanacimiento, Genero: varSexo, Telefono: telefono!)
            alumnosviewmodel.PostAlumnos(alumno: alumnoadd!) { ValidacionAlumno in
                DispatchQueue.main.async {
                    if ValidacionAlumno.Correct == true{
                        let alert = UIAlertController(title: "Correcto", message: "Se agrego el alumno correctamente", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true)
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }}
    }
    
    
    @IBAction func ActualizarAction(_ sender: Any) {
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let stringFromDate: String = dateFormater.string(from: self.DatePicker.date) as String
        let nombre = Nombretext.text
        let Apellidopaterno = Apellidopaternotext.text
        let Apellidomaterno = ApellidoMaternotext.text
        let fechanacimiento = stringFromDate
        let telefono = Telefono.text
        
        alumnoadd = Alumno(IdAlumno: 0, Nombre: nombre!, ApellidoPaterno: Apellidopaterno!, ApellidoMaterno: Apellidomaterno!, FechaNacimiento: fechanacimiento, Genero: varSexo, Telefono: telefono!)
        alumnosviewmodel.PostUpdate(IdAlumno: IdAlumno, alumno: alumnoadd!) { Objectalumno in
            DispatchQueue.main.async {
                if Objectalumno.Correct == true{
                   var correct = UIAlertController(title: "Correcto", message: "Se Actualizo Correctamente", preferredStyle: .alert)
                    correct.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(correct, animated: true)
                }
                else{
                    var error = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                    error.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(error, animated: true)
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
