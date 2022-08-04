//
//  ContentView.swift
//  CrosswalkSearch
//
//  Created by Paul Inventado on 4/8/22.
//

import SwiftUI
struct ContentView: View {
    @State var searchString: String = ""
    @StateObject var finder = CrosswalkFinder()
    @State var crosswalkname: String = ""
    @StateObject var history = SearchHistory()

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Crosswalk", text: $searchString)
                .modifier(TextEntry())

            Button(action: {
                finder.find(searchString)
                history.addSearchString(searchString)
            }) {
                Text("Find crosswalk")
            }
            .modifier(ButtonDesign())
            .padding(.bottom, 20)
            Text("Recent searches")
                .font(.headline)
            List(history.searchStrings, id: \.self) {
                storedSearchString in
                Button(action: {
                    searchString = storedSearchString
                    finder.find(searchString)
                    history.addSearchString(searchString)
                }) {
                    Text(storedSearchString)
                }
            }
            Text("Search result")
                .font(.largeTitle)
            Text(finder.firstFoundName)
                .font(.body)
            Image(uiImage: finder.image)
            Spacer()
        }.padding()
    }
}
