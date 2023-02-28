//
//  MateriasViewModel.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 23/02/23.
//

import Foundation

class MateriasViewModel{
    func getMaterias(ClousureMaterias : @escaping(Result<Materia>?) ->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Materia")
        urlsession.dataTask(with: url!){ data, response, error in
            if let safeData = data{
                let json = self.parseJson(data : safeData)
                ClousureMaterias(json)
            }
        }.resume()
    }
    
    func parseJson(data: Data)->Result<Materia>?{
        do{
            
            let decodable = JSONDecoder()
            let request = try decodable.decode(Result<Materia>.self, from: data)
            let Materias = Result(Correct: request.Correct, Object: request.Object, Objects: request.Objects)
            return Materias
        }
        catch let error{
            print("error en el decodable\(error.localizedDescription)")
            return nil
        }	
        
    }
    
    func PostMateria(materia: Materia, validacionMateria: @escaping(Result<Materia>)->Void){
        let decoder = JSONDecoder()
        let baseurl = "http://192.168.0.152/ControlEscolar/api/Materia"
        let url  = URL(string: baseurl)!
        var urlRequest  = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONEncoder().encode(materia)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest){
            data, response, error in
            if let safeData = data{
                let json = self.parseJson(data: safeData)
                validacionMateria(json!)
            }
        }.resume()
    }
    func GetById( IdMateria: Int, Object : @escaping(Result<Materia>)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Materia/\(IdMateria)")
        urlsession.dataTask(with: url!){
            data, response, error in
            if let safedata = data{
                let json = self.parseJson(data: safedata)
                Object(json!)
            }
        }.resume()
    }
    func PostUpdate(materia: Materia, IdMateria : Int, ObjectPost: @escaping(Result<Materia>)->Void){
        let decoder = JSONDecoder()
        let URL = URL(string: "http://192.168.0.152/ControlEscolar/api/Materia/\(IdMateria)")
        var urlrequest = URLRequest(url: URL!)
        urlrequest.httpMethod = "POST"
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlrequest.httpBody = try! JSONEncoder().encode(materia)
        let urlsession = URLSession.shared
        urlsession.dataTask(with: urlrequest){ [self]
            data, response, error in
            if let safeData = data{
                let json = parseJson(data: safeData)
                ObjectPost(json!)
            }
        }.resume()
        
    }
    func Delete(idmateria: Int){
        
    }
    
}
