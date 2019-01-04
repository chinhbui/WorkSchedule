//
//  MassiveAppDelegate-Commands.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    func execute() {
        // Third parties are initialized here
    }
}

struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow
    
    func execute() {
        // Pick root view controller here
        //keyWindow.rootViewController = UIViewController()
    }
}

struct InitializeAppearanceCommand: Command {
    func execute() {
        // Setup UIAppearance
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        // Register for remote notifications here
    }
}
