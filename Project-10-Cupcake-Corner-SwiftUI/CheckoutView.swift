//
//  CheckoutView.swift
//  Project-10-Cupcake-Corner-SwiftUI
//
//  Created by Baris Karalar on 29.06.2021.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var conformationMessage = ""
    @State private var showingConfirmation = false
    
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                VStack {
                    
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text("a asdf sfsd"), message: Text(conformationMessage), dismissButton: .default(Text("Okk")))
        })
        
        
    }
    
    func placeOrder() {
        //  1. Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        
        //  2. Prepare a URLRequest to send our encoded data as JSON.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        //  3. Run that request and process the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("no data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                conformationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) is on its way, hurray!!!"
                showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
            
        }.resume()
        
        
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
