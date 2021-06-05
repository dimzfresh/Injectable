## Injectable

Dependency Injection using Swift Property Wrappers

## How it works?

Define services:
```
protocol NetworkProtocol {
    func request()
}
```

For example, inject dependencies in AppDelegate that need to be injectable with property:

```
DependencyContainer {
    Dependency { NetworkService() }
    \\ ...
}
.build()
```

Define injectable properties where it needed:

```
@Injectable private var networkService: NetworkProtocol
```
Use your injectable service :)
```
networkService.request()
```
