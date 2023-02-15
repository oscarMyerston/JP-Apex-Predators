//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Oscar David Myerston Vega on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    
    let apController = PredatorController()
    @State var sortAlphabetical = false
    @State var currentFilter = "All"
    @State var currentMovieFilter = "All"
    
    var body: some View {
        apController.filterBy(type: currentFilter)
        apController.filterByMovie(type: currentMovieFilter)
        if sortAlphabetical {
            apController.sortByAlphabetical()
        } else {
            apController.sortByMovieAppearance()
        }
        
        return NavigationView {
            List {
                ForEach(apController.apexPredators) { predator in
                    NavigationLink(destination: PredatorDetail(predator: predator)) {
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            sortAlphabetical.toggle()
                        }
                    } label: {
                        if sortAlphabetical {
                            Image(systemName: "film")
                        } else {
                            Image(systemName: "textFormat")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentFilter.animation()) {
                            ForEach(apController.typeFilters, id: \.self) { type in
                                HStack {
                                    Text(type)
                                    Spacer()
                                    Image(systemName: apController.typeIcon(for: type))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("MovieFilter", selection: $currentMovieFilter.animation()) {
                            ForEach(apController.movieFilters, id: \.self) { type in
                                HStack {
                                    Text(type)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "video")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
