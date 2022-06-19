
import Cocoa
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


func getIntensity() {
    guard let apiUrl = URL(string: "https://api.carbonintensity.org.uk/intensity")
    else {return}
        let task = URLSession.shared.dataTask(with: apiUrl) {
            data, response, error in
        if let data = data {
            do {
                let tasks = try JSONDecoder().decode(carbonIntensity.self, from: data)
                let subTasks = (tasks.data)
                ModelData.shared.globalIndex = subTasks[0].intensity.index
                //ModelData.shared.globalIndex = tasks.data[0].intensity.index
            } catch {
                print("An error occured:", error)
            }
            statusMenuColour()
        }
    }
    task.resume()
}
