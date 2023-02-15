//
//  PredatorController.swift
//  JP Apex Predators
//
//  Created by Oscar David Myerston Vega on 15/02/23.
//

import Foundation

class PredatorController {
    var apexPredators: [ApexPredator] = []
    let typeFilters = ["All", "Land", "Air", "Sea"]
    let movieFilters = ["All", "Jurassic Park", "The Lost World: Jurassic Park", "Jurassic Park III", "Jurassic World", "Jurassic World: Fallen Kingdom"]
    private var allApexPredators: [ApexPredator] = []
    
    init() {
        self.decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                debugPrint("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func filterBy(type: String) {
        switch type {
        case "Land", "Air", "Sea":
            apexPredators = allApexPredators.filter {
                $0.type == type.lowercased()
            }
        default: apexPredators = allApexPredators
        }
        
    }
    
    func filterByMovie(type: String) {
        switch type {
        case "Jurassic Park", "The Lost World: Jurassic Park", "Jurassic Park III", "Jurassic World", "Jurassic World: Fallen Kingdom": apexPredators = allApexPredators.filter {
            $0.movies.contains(type)
        }
        default: apexPredators = allApexPredators
        }
    }
    
    func typeIcon(for type: String) -> String {
        switch type {
        case "All": return "square.stack.3d.up.fill"
        case "Land": return "leaf.fill"
        case "Air": return "wind"
        case "Sea": return "drop.fill"
        default: return "questionmark"
        }
    }
    
    func sortByAlphabetical () {
        apexPredators.sorted(by: { $0.name < $1.name })
    }
    
    func sortByMovieAppearance() {
        apexPredators.sorted(by:  { $0.id < $1.id })
    }
}
