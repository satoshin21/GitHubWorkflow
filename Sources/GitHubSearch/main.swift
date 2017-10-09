
import Foundation
import AlfredKit
import APIKit

let alfred = Alfred()

guard CommandLine.arguments.count >= 2 else {

    exit(1)
}

let arg = CommandLine.arguments[1]

let semaphor = DispatchSemaphore(value: 0)
Session.send(GitHubAPI.SearchRepositories(query: arg), callbackQueue: .sessionQueue)
{ result in

    switch result {

    case .success(let response):
        response.items.map{ Item(title: $0.fullName) }.forEach({ item in
            alfred.add(item: item)
        })

    default:
        break
    }

    semaphor.signal()
}

semaphor.wait()
try? alfred.export()
