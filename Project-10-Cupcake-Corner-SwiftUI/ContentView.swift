//
//  ContentView.swift
//  Project-10-Cupcake-Corner-SwiftUI
//
//  Created by Baris Karalar on 27.06.2021.
//

import SwiftUI

//Validating and disabling forms

struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            //            .disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
            
            
        }
        
    }
}

////Sending and receiving Codable data with URLSession and SwiftUI
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct ContentView: View {
//
//    @State private var results = [Result]()
//
//    var body: some View {
//
//        List(results, id: \.trackId) { item in
//            VStack {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//
//            }
//        }
////        .onAppear(perform: loadData)
//        .onAppear(perform: {
//            loadData()
//        })
//
//
//    }
//
//    func loadData() {
//
////        1. Creating the URL we want to read.
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid url")
//            return
//        }
//
////        2. Wrapping that in a URLRequest, which allows us to configure how the URL should be accessed.
//        let request = URLRequest(url: url)
//
////        3. Create and start a networking task from that URL request.
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            //        4. Handle the result of that networking task.
//            if let data = data {
//
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                    // we have good data – go back to the main thread
//                    DispatchQueue.main.async {
//                        //update the ui
//                        self.results = decodedResponse.results
//
//                        // everything is good, so we can exit
//                        return
//                    }
//                }
//                // if we're still here it means there was a problem
//                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//
//
//            }
//
//
//        }.resume()
//
//
//
//    }
//}



////Adding Codable conformance for @Published properties
//
//class User: ObservableObject, Codable {
//
//    enum CodingKeys: CodingKey {
//        case name
//
//    }
//
//    @Published var name = "Baris Karalar"
////    var age = "34"
////    @Published var nickName = "karalarbaris"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
