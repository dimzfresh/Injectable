# Injectable

Dependency Injection using Swift Property Wrappers

How it works?

For example, inject dependencies in AppDelegate that need to be injectable with property:

DependencyContainer {
    Dependency { LocationService() }
    Dependency { StorageService() }
    // etc
}
.build()

Define injectable properties:

@Injecable var networkClient: NetworkClient
@Injecable var userService: UserService
