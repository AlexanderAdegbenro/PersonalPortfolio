//
//  OnBoarding1.swift
//  NOFH
//
//  Created by Alexander Adegbenro on 9/28/21.
//

import SwiftUI
import Firebase
struct ContentView: View {
    
    @State private var selection = 0
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        if currentPage > totalPages {
            Home()
            
        }
        else {
            WalkthroughScreen()
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ScreenView(image: "FriendshipImage", title: "No more back and forth", subtitle: "Skip the texting back and forth,which reduces your chances of getting ghosted.", detail: "", bgColor: Color("Color1"))
        
        
        
    }
}

// Home Page....

struct Home: View {
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 90){
                
                Image("Buddies")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                
                VStack(spacing: 10){
                    Text("No more back and forth")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Montserrat-SemiBold", size: 24))
                    
                    VStack(spacing: 50){
                        
                        VStack(spacing: 5){
                            Text("Skip the texting back and forth,which reduces")
                                .foregroundColor(Color("Grey"))
                                .font(.custom("Montserrat-Regular", size: 14))
                                .multilineTextAlignment(.center)
                            
                            Text(" your chances of getting ghosted.")
                                .foregroundColor(Color("Grey"))
                                .font(.custom("Montserrat-Regular", size: 14))
                                .multilineTextAlignment(.center)
                            
                            
                        }
                        
                        
                        VStack(spacing: 5){
                            
                            NavigationLink(destination: SignInview()) {
                                Text("Sign in")
                                    .font(.custom("Montserrat-SemiBold", size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 327,height: 20)
                                    .font(.title)
                                    .foregroundColor(Color("Color2"))
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("Color3"), lineWidth: 2)
                                    )
                            }
                            
                        }
                    }
                    
                    NavigationLink(destination:RegisterView()) {
                        Text("Register")
                            .font(.custom("Montserrat-SemiBold", size: 14))
                            .fontWeight(.semibold)
                            .frame(width: 327,height: 20)
                            .padding()
                            .foregroundColor(Color("Color4"))
                            .background(Color("Color3"))
                            .cornerRadius(15)
                            .font(.title)
                    }
                }
                
                
                
                
                
            }
        }
    }
}




// WalkThrough SCreen....

struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
        // For Slide Animation...
        
        ZStack{
            
            // Changing Between Views....
            
            if currentPage == 1{
                ScreenView(image: "Video call-pana 1", title: "Meet people in a quick way", subtitle:"NOFH allows people from all over the world to meet quickly and get to know each other." , detail: "", bgColor: Color("Color1"))
                    .transition(.scale)
                    .foregroundColor(Color("Color1"))
            }
            if currentPage == 2{
                
                ScreenView(image: "FriendshipImage", title: "Build real relationships", subtitle: "There’s absolutely no cat fishing involved. You build real and meaningful relationships.", detail: "", bgColor: Color("Color1"))
                    .transition(.scale)
                    .foregroundColor(Color("Color1"))
                
            }
            
            if currentPage == 3{
                
                ScreenView(image: "Buddies", title: "No more back and forth", subtitle: "Skip the texting back and forth,which reduces your chances of getting ghosted.", detail: "", bgColor: Color("Color1"))
                
                    .transition(.scale)
                    .foregroundColor(Color("Color1"))
                
            }
            
        }
        
        .overlay(
            
            // Button...
            Button(action: {
                // changing views...
                withAnimation(.easeInOut){
                    
                    // checking....
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                }
            }, label: {
                
                Image("Arrow - Right")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color("Color2"))
                    .frame(width: 62, height: 62)
                    .background(Color("Color3"))
                    .clipShape(Circle())
                // Circlular Slider...
                    .overlay(
                        
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                            
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color("Color2"),lineWidth: 2)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
            })
                .padding(.bottom,20)
            
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var subtitle: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                
                
                // Showing it only for first Page...
                if currentPage == 1{
                    // Letter Spacing...
                    
                }
                else{
                    // Back Button...
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("Color2"))
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                        
                    })
                }
                
                Spacer()
                
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Montserrat-SemiBold", size: 15))
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            Text(title)
                .kerning(-1)
                .padding(.top)
                .font(.custom("Montserrat-SemiBold", size: 24))
                .foregroundColor(Color("Color2"))
                .frame(width: 329,height: 40)
                .lineSpacing(10)
            
            
            Text(subtitle)
                .kerning(0.100)
                .multilineTextAlignment(.center)
                .font(.custom("Montserrat-Regular", size: 14))
                .foregroundColor(Color("Grey"))
                .lineSpacing(10)
                .frame(width: 327,height: 45)
            
            
            
            // Minimum Spacing When Phone is reducing...
            
            Spacer(minLength: 150)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

// total Pages...
var totalPages = 3






