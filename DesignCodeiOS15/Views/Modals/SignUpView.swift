//
//  SignUpView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 30/10/23.
//

import SwiftUI

struct SignUpView: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    @State private var email = ""
    @State private var password = ""
    @FocusState var focusedField: Field?
    @State var circleY: CGFloat = 120
    @State private var emailY: CGFloat = 0
    @State private var passwordY: CGFloat = 0
    @State private var circleColor: Color = .blue
    @State private var appear = [false, false, false]
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sign up")
                .font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y: appear[0] ? 0 : 20)
            Text("Access 120+ hours of courses, tutorials and livestreams")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y: appear[1] ? 0 : 20)
            
            Group {
                TextField("Email", text: $email)
                    .inputStyle(icon: "mail")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                    .shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        emailY = value
                        circleY = value
                    }
                
                SecureField("Password", text: $password)
                    .inputStyle(icon: "lock")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        passwordY = value
                    }
                
                Button(action: {}, label: {
                    Text("Create an account")
                        .frame(maxWidth: .infinity)
                })
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.accentColor)
                .controlSize(.large)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
                
                Text("By clicking on ")
                + Text("_Create an account_").foregroundColor(Color.primary.opacity(0.7))
                + Text(", you agree to our **Terms of Service** and **[Privacy Policy](https://designcode.io)**")
                
                Divider()
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        model.selectedModal = .signIn
                    }, label: {
                        Text("**Sign In**")
                    })
                }
                .font(.footnote)
                .foregroundColor(Color.secondary)
                .accentColor(Color.secondary)
            }
            .opacity(appear[2] ? 1 : 0)
            .offset(y: appear[2] ? 0 : 20)
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background (
            Circle().fill(circleColor)
                .frame(width: 68, height: 68)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(y: circleY)
        )
        .coordinateSpace(name: "container")
        .strokeStyle(cornerRadius: 30)
        .onChange(of: focusedField) { value in
            withAnimation {
                if value == .email {
                    circleY = emailY
                    circleColor = .blue
                } else {
                    circleY = passwordY
                    circleColor = .red
                }
            }
        }
        .onAppear {
            withAnimation(.spring.delay(0.1)) {
                appear[0] = true
            }
            withAnimation(.spring.delay(0.2)) {
                appear[1] = true
            }
            withAnimation(.spring.delay(0.3)) {
                appear[2] = true
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
                .environmentObject(Model())
        }
    }
}

extension SignUpView {
    private var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        }
    }
}
