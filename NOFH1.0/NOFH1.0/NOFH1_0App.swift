//
//  NOFH1_0App.swift
//  NOFH1.0
//
//  Created by Alexander Adegbenro on 10/18/21.
//

import SwiftUI

@main
struct NOFH1_0App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
