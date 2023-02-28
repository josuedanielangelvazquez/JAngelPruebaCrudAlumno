//
//  AlumnosTableViewController.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 22/02/23.
//

import UIKit
import SwipeCellKit
class AlumnosTableViewController: UITableViewController {
     var alumnos = [Alumno]()
    var alumnoviewmodel = AlumnoViewModel()
    var IdAlumno = 0
    var seguesdet = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AlumnosTableViewCell", bundle: .main), forCellReuseIdentifier: "AlumnosCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()

    }
    func loadData(){
        let result = alumnoviewmodel.getAlumnos { getalumnos in
            DispatchQueue.main.async {
                if getalumnos != nil{
                    self.alumnos = getalumnos?.Objects as! [Alumno]
                    self.tableView.reloadData()
                }
                else{
                    var alert = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alumnos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlumnosCell", for: indexPath as IndexPath) as! AlumnosTableViewCell
        cell.delegate = self
        cell.IdAlumno.text = String(alumnos[indexPath.row].IdAlumno)
        cell.Nombrelbl.text = alumnos[indexPath.row].Nombre
        cell.ApellidoPaternolbl.text = alumnos[indexPath.row].ApellidoPaterno
        cell.ApellidoMaternolbl.text = String(alumnos[indexPath.row].ApellidoMaterno)
        cell.FechaNacimientolbl.text = alumnos[indexPath.row].FechaNacimiento
        cell.Generolbl.text = alumnos[indexPath.row].Genero
        cell.Telefonolbl.text = alumnos[indexPath.row].Telefono
        return cell
    }
    
  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IdAlumno = alumnos[indexPath.row].IdAlumno
        seguesdet = "UpdateSeguesAlumno"
        performSegue(withIdentifier: "UpdateSeguesAlumno", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSeguesAlumno"{
            let ObjectAlumno = segue.destination as! AlumnosViewController
            ObjectAlumno.IdAlumno = IdAlumno
            ObjectAlumno.segues = seguesdet
        }
    }*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AlumnosTableViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        /*   if orientation == .right{
         
         
         let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
         action, indexPath in
         
         self.idMateria = self.materias[indexPath.row].IdMateria
         
         let result = self.productoviewmodel.Delete(var: self.idproducto)
         if result.Correct{
         self.loaddData()
         let alert = UIAlertController(title: "oK", message: "El producto se elimino correctamente", preferredStyle: .alert)
         let Ok = UIAlertAction(title: "oK", style: .default)
         alert.addAction(Ok)
         self.present(alert, animated: true)
         
         }
         else{
         let alert = UIAlertController(title: "Alerta", message: "Ocurrio un Error", preferredStyle: .alert)
         let Ok = UIAlertAction(title: "Ok", style: .default)
         alert.addAction(Ok)
         self.present(alert, animated: true)
         }
         }
         deleteAction.image = UIImage(named: "delete")
         return [deleteAction]
         }*/
        
        
        let  UpdateAction = SwipeAction(style: .destructive , title: "Update"){
            action, indexPath in
            
            self.IdAlumno = self.alumnos[indexPath.row].IdAlumno
            self.performSegue(withIdentifier: "UpdateSeguesAlumno", sender: nil)
            
            
        }
        UpdateAction.image = UIImage(named: "Update")
        UpdateAction.backgroundColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        return [UpdateAction]
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
           if segue.identifier == "UpdateSeguesAlumno"{
               let detail = segue.destination as! AlumnosViewController
               detail.IdAlumno = IdAlumno
               detail.segues = "UpdateSeguesAlumno"
           }
               }
           
           }
           



