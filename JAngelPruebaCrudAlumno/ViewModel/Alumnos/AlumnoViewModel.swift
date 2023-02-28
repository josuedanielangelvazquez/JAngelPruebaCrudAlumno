//
//  AlumnoViewModel.swift
//  JAngelPruebaCrudAlumno
//
//  Created by MacBookMBA6 on 23/02/23.
//

import Foundation
class AlumnoViewModel{
    func getAlumnos(ClousureAlumnos : @escaping (Result<Alumno>?)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/alumno")
        urlsession.dataTask(with: url!){data, response, error in
            if let safedata = data{
                let json = self.ParseJson(data: safedata)
                ClousureAlumnos(json)
            }
            else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
    func ParseJson(data: Data)->Result<Alumno>?{
        let decodable = JSONDecoder()
        do{
            let request = try decodable.decode(Result<Alumno>.self, from: data)
            let alumnos = try! Result<Alumno>(Correct: request.Correct, ErrorMessage: request.ErrorMessage, Object: request.Object, Objects: request.Objects)
            print(alumnos)
            return alumnos
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
                      return nil
        }
        
        
    }
    
    func PostAlumnos(alumno: Alumno, validacionAlumnos: @escaping(Result<Alumno>)->Void){
        let decoder = JSONDecoder()
        let baseurl = "http://192.168.0.152/ControlEscolar/api/Alumno"
        let url  = URL(string: baseurl)!
        var urlRequest  = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONEncoder().encode(alumno)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest){
            data, response, error in
            if let safeData = data{
                let json = self.ParseJson(data: safeData)
                validacionAlumnos(json!)
            }
        }.resume()
    }
    func GetByiD(IdAlumno : Int, validacionAlumnos: @escaping(Result<Alumno>)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Alumno/\(IdAlumno)")
        urlsession.dataTask(with: url!){ [self] data, response, error in
            if let safedata = data{
                let json = ParseJson(data: safedata)
                validacionAlumnos(json!)
                
            }
        }.resume()
        
    }
    func PostUpdate(IdAlumno : Int, alumno: Alumno, ObjectAlumno : @escaping(Result<Alumno>)->Void){
        let decoder = JSONDecoder()
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Alumno/\(IdAlumno)")
        var urlrequest = URLRequest(url: url!)
        urlrequest.httpMethod = "POST"
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlrequest.httpBody = try! JSONEncoder().encode(alumno)
        let urlsession = URLSession.shared
        urlsession.dataTask(with: urlrequest){ [self]
            data, response, error in
            if let safeData = data{
                let json = ParseJson(data: safeData)
                ObjectAlumno(json!)
            }
        }.resume()
        
    }
}
