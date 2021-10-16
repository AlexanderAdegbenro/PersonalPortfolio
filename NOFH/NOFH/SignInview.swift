//
//  SignInViewController.swift
//  NOFH
//
//  Created by Alexander Adegbenro on 10/4/21.
//

import SwiftUI
import Firebase

struct SignInview: View {
    var body: some View {
        
        SigninPage()
    }
}

struct SignInview_Previews: PreviewProvider {
    static var previews: some View {
        SignInview()
    }
}
struct SigninPage : View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        
        NavigationView{
            
            VStack{
                
                if self.status{
                    
                    Homescreen()
                }
                else{
                    
                    ZStack{
                        
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            
                            Text("")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}
    
struct Homescreen : View {
        
        var body: some View{
            
            VStack{
                
                Text("Logged successfully")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.7))
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }) {
                    
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Color2"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
        }
    }

    struct Login : View {
        
        @State var color = Color.black.opacity(0.7)
        @State var email = ""
        @State var pass = ""
        @State var visible = false
        @Binding var show : Bool
        @State var alert = false
        @State var error = ""
        
        var body: some View{
            
            ZStack{
                
                ZStack(alignment: .topTrailing) {
                    
                    GeometryReader{_ in
   
                        VStack(spacing: 10){
                            
                            
                            VStack(spacing: 40){
                            Image("mini-logo")
                                    .resizable()
                                    .frame(width: 133.53, height: 39.0)
                            
                            Text("Welcome back! Login to enter. :)")
                                .foregroundColor(Color("Color2"))
                                .font(.custom("Montserrat-SemiBold", size: 20))
                                .multilineTextAlignment(.center)
                                .frame(width: 380,height: 27)
                                
                                
                                
                            }

                            VStack(spacing:0){
                            
                            //Start of Text Field
                            TextField("Email", text: self.$email)
                                .disableAutocorrection(true)
                                .padding()
                                .background(Color("Fields"))
                                .cornerRadius(15)
                                .frame(width: 380,height: 27)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            .background(RoundedRectangle(cornerRadius: 15).stroke(self.email != "" ? Color("Fields") : self.color,lineWidth: 0))
                            
                            .padding(.top, 25)
                            
                            
                            HStack(spacing: -20){
                                
                                VStack(){
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .padding()
                                        .background(Color("Fields"))
                                        .cornerRadius(15)
                                        .frame(width: 380,height: 27)
                                        .disableAutocorrection(true)
                                        
                                    }
                                    else{
                                        
                                        SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .padding()
                                        .background(Color("Fields"))
                                        .cornerRadius(15)
                                        .frame(width: 380,height: 27)
                                        .disableAutocorrection(true)
                                        
                                    }
                                }
        
                        HStack(spacing:50) {
                                Button(action: {
                                    
                                    self.visible.toggle()
                                    
                                }) {
                                    
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                        
                                }
                                }
                                
                            }
                            .padding()

                            .background(RoundedRectangle(cornerRadius: 15).stroke(self.pass != "" ? Color("Fields") : self.color,lineWidth: 0))
                            .frame(width: 327,height: 57)
                            .padding(.top, 25)
                           }
         
                            HStack(spacing: 20){
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    self.reset()
                                    
                                }) {
                                    
                                    Text("Forgot password?")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color2"))
                                        .font(.custom("Montserrat", size: 12))
                                        .fontWeight(.semibold)
                                }
                            }
                            .padding(.top, 10)
                            
                            Button(action: {
                                
                                self.verify()
                                
                            }) {
                                
                                Text("Sign in")
                                    .font(.custom("Montserrat-SemiBold", size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 327,height: 25)
                                    .foregroundColor(Color("Color4"))
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("Color3"))
                            .cornerRadius(15)
                            .font(.title)
                            .padding(.top, 20)
                            
                        }
                        .padding(.horizontal, 25)
                    }
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Color2"))
                    }
                    .padding()
                }
                
                if self.alert{
                    
                    ErrorView(alert: self.$alert, error: self.$error)
                }
                
            }
        }
        
        func verify(){
            
            if self.email != "" && self.pass != ""{
                
                Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                    
                    if err != nil{
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                
                self.error = "Please fill all the contents properly"
                self.alert.toggle()
            }
        }
        
        func reset(){
            
            if self.email != ""{
                
                Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                    
                    if err != nil{
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    self.error = "RESET"
                    self.alert.toggle()
                }
            }
            else{
                
                self.error = "Email Id is empty"
                self.alert.toggle()
            }
        }
    }

    struct SignUp : View {
        
        @State var color = Color.black.opacity(0.7)
        @State var email = ""
        @State var pass = ""
        @State var repass = ""
        @State var visible = false
        @State var revisible = false
        @Binding var show : Bool
        @State var alert = false
        @State var error = ""
        
        var body: some View{
            
            ZStack{
                
                ZStack(alignment: .topLeading) {
                    
                    GeometryReader{_ in
                        
                        VStack{
                            
                            Image("logo")
                            
                            Text("Log in to your account")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(self.color)
                                .padding(.top, 35)
                            
                            TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                            .padding(.top, 25)
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                    }
                                }
                                
                                Button(action: {
                                    
                                    self.visible.toggle()
                                    
                                }) {
                                    
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                       
                                }
                                
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth: 2))
                            .padding(.top, 25)
                            
                            HStack(spacing: 10){
                                
                                VStack{
                                    
                                    if self.revisible{
                                        
                                        TextField("Re-enter", text: self.$repass)
                                        .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Re-enter", text: self.$repass)
                                        .autocapitalization(.none)
                                    }
                                }
                                
                                Button(action: {
                                    
                                    self.revisible.toggle()
                                    
                                }) {
                                    
                                    Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                }
                                
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color,lineWidth: 2))
                            .padding(.top, 25)
                            
                            Button(action: {
                                
                                self.register()
                            }) {
                                
                                Text("Sign up")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("Color"))
                            .cornerRadius(10)
                            .padding(.top, 25)
                            
                        }
                        .padding(.horizontal, 25)
                    }
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(Color("Color"))
                    }
                    .padding()
                }
                
                if self.alert{
                    
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        
        func register(){
            
            if self.email != ""{
                
                if self.pass == self.repass{
                    
                    Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                        
                        if err != nil{
                            
                            self.error = err!.localizedDescription
                            self.alert.toggle()
                            return
                        }
                        
                        print("success")
                        
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    }
                }
                else{
                    
                    self.error = "Password mismatch"
                    self.alert.toggle()
                }
            }
            else{
                
                self.error = "Please fill all the contents properly"
                self.alert.toggle()
            }
        }
    }


    struct ErrorView : View {
        
        @State var color = Color.black.opacity(0.7)
        @Binding var alert : Bool
        @Binding var error : String
        
        var body: some View{
            
            GeometryReader{_ in
                
                VStack{
                    
                    HStack{
                        
                        Text(self.error == "RESET" ? "Message" : "Error")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    
                    Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                    
                    Button(action: {
                        
                        self.alert.toggle()
                        
                    }) {
                        
                        Text(self.error == "RESET" ? "Ok" : "Cancel")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
                }
                .padding(.vertical, 25)
                .frame(width: UIScreen.main.bounds.width - 70)
                .background(Color.white)
                .cornerRadius(15)
            }
            .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        }
    }

    
//    var body: some View {
//
//        VStack (spacing: 20){
//            VStack {
//                Image("mini-logo")
//                    .resizable()
//                    .frame(width: 133.53, height: 39.0)
//
//                Text("Welcome back! Login to enter. :)")
//                    .foregroundColor(Color("Color2"))
//                    .font(.custom("Montserrat-SemiBold", size: 20))
//                    .multilineTextAlignment(.center)
//
//                VStack {
//                    TextField("Email", text: $email)
//                        .disableAutocorrection(true)
//                        .padding()
//                        .background(Color("Fields"))
//                        .cornerRadius(15)
//                        .frame(width: 380,height: 57)
//
//
//                    SecureField("Password", text: $password)
//                        .disableAutocorrection(true)
//                        .padding()
//                        .background(Color("Fields"))
//                        .cornerRadius(15)
//                        .frame(width: 380,height: 57)
//                }
//
//                NavigationLink(destination:  SignInview()) {
//
//                        Text("Sign in")
//                            .font(.custom("Montserrat-SemiBold", size: 14))
//                            .fontWeight(.semibold)
//                            .frame(width: 327,height: 25)
//                            .padding()
//                            .foregroundColor(Color("Color4"))
//                            .background(Color("Color3"))
//                            .cornerRadius(15)
//                            .font(.title)
//
//                }
//            }
//
//
//            //                VStack (spacing: 20) {
//
//            NavigationLink(destination:  SignInview()) {
//                Text("Continue with Apple")
//                    .font(.custom("Montserrat-SemiBold", size: 14))
//                    .fontWeight(.semibold)
//                    .frame(width: 327,height: 25)
//                    .font(.title)
//                    .foregroundColor(Color("Color2"))
//                    .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("Color2"), lineWidth: 2)
//                    )
//            }
//            NavigationLink(destination:  SignInview()) {
//                Text("Continue with google")
//                    .font(.custom("Montserrat-SemiBold", size: 14))
//                    .fontWeight(.semibold)
//                    .frame(width: 327,height: 25)
//                    .font(.title)
//                    .foregroundColor(Color("Color2"))
//                    .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("Color2"), lineWidth: 2)
//                    )
//            }
//            NavigationLink(destination:  SignInview()) {
//                Text("Continue with Phone Number")
//                    .font(.custom("Montserrat-SemiBold", size: 14))
//                    .fontWeight(.semibold)
//                    .frame(width: 327,height: 25)
//                    .font(.title)
//                    .foregroundColor(Color("Color2"))
//                    .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("Color2"), lineWidth: 2)
//                    )
//            }
//
//        }
//        Spacer()
//    }
//
//
//}
  
