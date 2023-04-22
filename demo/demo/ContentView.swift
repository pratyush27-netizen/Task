//
//  ContentView.swift
//  demo
//
//  Created by PRATYUSH on 18/04/23.
//
import SwiftUI
struct ContentView: View {
    @State private var carOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var isActive = false
    var body: some View {
        VStack {
                    Image("travel")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Text("Explore the world with us!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.bottom, 10)
           // Display an image that resizes to fit the frame, has fixed dimensions and can be animated
                    Image("car")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(x: carOffset)
                        .animation(Animation.linear(duration: 3.5))
                        .onAppear {
                            // Move the car off the screen when it appears
                            carOffset = UIScreen.main.bounds.width
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        isActive = true
                    }
                }
                .fullScreenCover(isPresented: $isActive, content: {
                    
                    TableViewPage()
                })
        
    }
}

struct TableViewPage: View {
    // Define an array of items with titles, descriptions and image URLs
    let data = [
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 1", description: "Description 1"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 2", description: "Description 2"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 3", description: "Description 3"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 4", description: "Description 4"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 5", description: "Description 5"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 6", description: "Description 6"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 7", description: "Description 7"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 8", description: "Description 8"),
        TableRow(imageName: "https://picsum.photos/200/300", title: "Title 9", description: "Description 9")
    ]
    
    var body: some View {
        VStack {
            Text("CIAO!")
                .bold()
                .font(.headline)
                                .foregroundColor(Color(UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)))
            List(data) { row in
                TableRow(imageName: row.imageName, title: row.title, description: row.description)
            }
        }
        
    }
}

struct TableRow: View, Identifiable {
    let id = UUID()
    var imageName: String
    var title: String
    var description: String
    
    @State private var checkbox: Bool = false
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageName)) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                checkbox.toggle()
            }, label: {
                Image(systemName: checkbox ? "checkmark.square.fill" : "square")
            })
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
