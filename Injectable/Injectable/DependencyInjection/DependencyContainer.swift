import Foundation

// MARK: DependencyContainer

@dynamicMemberLookup
final class DependencyContainer: Sequence {

    // MARK: - Internal Properties

    private(set) static var shared = DependencyContainer()

    // MARK: - Fileprivate Properties

    fileprivate var dependencies: [String: Dependency] = [:]

    // MARK: - Lifecycle

    fileprivate init() {}

    // MARK: - DependencyBuilder

    @resultBuilder enum DependencyBuilder {
        static func buildBlock(_ dependency: Dependency) -> Dependency {
            dependency
        }
        static func buildBlock(_ dependencies: Dependency...) -> [Dependency] {
            dependencies
        }
    }

    @discardableResult
    init(@DependencyBuilder _ dependencies: () -> [Dependency]) {
        dependencies().forEach { register($0) }
    }

    @discardableResult
    init(@DependencyBuilder _ dependency: () -> Dependency) {
        register(dependency())
    }

    // MARK: - Sequence

    func makeIterator() -> AnyIterator<Any> {
        var iterator = dependencies.makeIterator()
        return AnyIterator { iterator.next()?.value.value }
    }

    // MARK: - Subscript

    subscript<T>(dynamicMember name: String) -> T? {
        let key = name.prefix(1).capitalized + name.dropFirst()
        return dependencies[key]?.value as? T
    }

    // MARK: - Internal Methods

    func register(_ dependency: Dependency) {
        guard dependencies[dependency.name] == nil else {
            debugPrint("\(String(describing: dependency.name)) is already registered")
            return
        }
        dependencies[dependency.name] = dependency
    }

    func build() {
        dependencies.keys.forEach { dependencies[$0]?.resolve() }
        Self.shared = self
    }

    func resolve<T>() -> T {
        guard let dependency = dependencies.first(where: { $0.value.value is T })?.value.value as? T else {
            fatalError("Can't resolve \(T.self)")
        }
        return dependency
    }

    func remove(_ removingDependencies: [String]) {
        removingDependencies.forEach {
            self.dependencies[$0] = nil
        }
    }
}
