//
//  AccountView.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name" ,text: $viewModel.user.firstName)
                    TextField("Last Name" ,text: $viewModel.user.lastName)
                    TextField("Email" ,text: $viewModel.user.email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    DatePicker("Date of Birth", selection: $viewModel.user.dob, displayedComponents: .date)
                    Button {
                        viewModel.saveChanges()
                    } label: {
                        Text("Save Changes")
                    }
                } header: {
                    Text("Personal Info")
                }
                
                Section {
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent Refils", isOn: $viewModel.user.frequentRefils)
                } header: {
                    Text("Other Requests")
                }
                .tint(.primaryGreen)
            }
            .navigationTitle("👨🏽‍🦲 Account")
        }
        .onAppear {
            viewModel.retreiveUserInfo()
        }
        .alert(item: $viewModel.alertItem) { alert  in
            Alert(title: alert.title, message: alert.message, dismissButton:alert.dismissButton)
        }
    }
}

#Preview {
    AccountView()
}
