//
//  RefactoringAppDelegate-Command.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

// MARK: - Builder

final class StartupCommandsBuilder {
    private var window: UIWindow!
    
    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }
    
    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
            InitializeAppearanceCommand(),
            RegisterToRemoteNotificationsCommand()
        ]
    }
}

// MARK: - App Delegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StartupCommandsBuilder()
            .setKeyWindow(window!)
            .build()
            .forEach { $0.execute() }

        return true
    }
}
