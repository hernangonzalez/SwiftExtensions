import Foundation
import XCGLogger

public final class Logger: XCGLogger {
    struct Destination {}
    
    // Singleton
    static func instance() -> Logger {
        let log = Logger(identifier: "com.polarsteps.logger", includeDefaultDestinations: false)
        
        // Destinations
        log.add(destination: Destination.console())        
        log.logAppDetails()
        return log
    }
    
    static let shared = instance()
}

public let logger = Logger.shared

// MARK: Destinations
extension Logger.Destination {
    
    static func console() -> DestinationProtocol {
        let console = ConsoleDestination(identifier: "com.polarsteps.logger.console")
        console.outputLevel = .debug
        console.showLevel = false
        console.showDate = false
        
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯 ", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹 ", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ ", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️ ", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️ ", to: .error)
        emojiLogFormatter.apply(prefix: "💥 ", to: .severe)
        console.formatters = [emojiLogFormatter]
        
        return console
    }
}
