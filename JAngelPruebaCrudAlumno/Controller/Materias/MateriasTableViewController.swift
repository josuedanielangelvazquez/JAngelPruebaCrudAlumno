//
//  MateriasTableViewController.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 23/02/23.
//

import UIKit
import SwipeCellKit
class MateriasTableViewController: UITableViewController {
    var materias = [Materia]()
    var materiaviewmodel = MateriasViewModel()
    var idMateria = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MateriasTableViewCell", bundle: .main), forCellReuseIdentifier: "MateriaCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()

    }
    func loadData(){
        let result = materiaviewmodel.getMaterias { GetMaterias in
            DispatchQueue.main.async {
                if GetMaterias != nil{
                    self.materias = GetMaterias?.Objects as! [Materia]
                    self.tableView.reloadData()
                }
                
                else{
                    var alert = UIAlertController(title: "Error", message: "Ocurrio un Error, Intentalo mas tarde", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
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
        return materias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriaCell", for: indexPath as IndexPath) as! MateriasTableViewCell
        cell.delegate = self
        cell.IdMaterialbl.text = String(materias[indexPath.row].IdMateria)
        cell.Nombrelbl.text = materias[indexPath.row].Nombre
        cell.Costolbl.text = String(materias[indexPath.row].Costo)
        return cell
    }
    
    
    @IBAction func SearchButton(_ sender: Any) {
        var searhc = UIAlertController(title: "¿?", message: "¿Ingresa el Id a buscar?", preferredStyle: .alert)
        searhc.addTextField{(textfield : UITextField) in
            textfield.placeholder = "Ingrese el Id"
            
        }
        searhc.addAction(UIAlertAction(title: "Cancelar", style: .destructive))
        searhc.addAction(UIAlertAction(title: "Buscar", style: .default){ [self] action in
            let arraytext = searhc.textFields
            let text = arraytext![0]
            let textString = String(text.text!)
            
            if Int(textString) != nil{
                self.idMateria = Int(textString)!
                print(idMateria)
            }
            else{
                searhc.title = "Error"
                searhc.message = "Ingrese un id valido"
             
            }

            self.materiaviewmodel.GetById(IdMateria: self.idMateria) { Validacion in
                DispatchQueue.main.async {
                    if Validacion.Object != nil{
                        self.performSegue(withIdentifier: "UpdateSeguesMateria", sender: nil)}
                    else{
                        searhc.title = "Error"
                        searhc.message = "Ingrese un Id Valido"
                        self.present(searhc, animated: true)
                        
                    }
                    }
                    
                }
            }
            
        )
        self.present(searhc, animated: true)
    }
    /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idMateria = materias[indexPath.row].IdMateria
        performSegue(withIdentifier: "UpdateSeguesMateria", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSeguesMateria"{
            let detail = segue.destination as! MateriaViewController
            detail.IdMateria = idMateria
            detail.segues = "UpdateSeguesMateria"
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
extension MateriasTableViewController: SwipeTableViewCellDelegate{
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
            
            self.idMateria = self.materias[indexPath.row].IdMateria
            self.performSegue(withIdentifier: "UpdateSeguesMateria", sender: nil)
            
            
        }
        UpdateAction.image = UIImage(named: "square.and.pencil.circle.fill")
        UpdateAction.backgroundColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        return [UpdateAction]
        
    }
           
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
           if segue.identifier == "UpdateSeguesMateria"{
               let detail = segue.destination as! MateriaViewController
               detail.IdMateria = idMateria
               detail.segues = "UpdateSeguesMateria"
           }
               }
           
           }
           


