//
//  apiCall.swift
//  Unplug
//
//  Created by Henry Gelderbloem on 16/06/2022.
//

import Foundation

struct carbonIntensity:Codable {
    var data: [Datum]
}

struct Datum:Codable {
    var from, to: String
    var intensity: IntensityClass
}

struct IntensityClass:Codable {
    var forecast, actual: Int?
    var index: String
}

public var currentIntensity = ""

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    var globalIndex = ""
}

func apiCall() {
    guard let url = URL(string: "https://api.carbonintensity.org.uk/intensity") else{
        return  }
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
        if let data = data, let string = String(data: data, encoding: .utf8){
        //print(string)
        decodeAPI()
        }
    }
    task.resume()
}

func decodeAPI(){
    guard let url = URL(string: "https://api.carbonintensity.org.uk/intensity") else{return}
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        let decoder = JSONDecoder()
        if let data = data{
            do{
                let tasks = try decoder.decode(carbonIntensity.self, from: data)
                //print("This is the output of tasks:", tasks.data)
                let subTasks = (tasks.data)
                ModelData.shared.globalIndex = subTasks[0].intensity.index
                //currentIntensity = subTasks[0].intensity.index
                //print(ModelData.shared.globalIndex)
            }catch{
                print("This is the error:", error)
            }
        }
    }
    task.resume()
}
