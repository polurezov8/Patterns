# Patterns

## Prototype
The prototype pattern is a creational design pattern in software development. It is used when the type of objects to create is determined by a prototypical instance, which is cloned to produce new objects. This pattern is used to:
* Avoid subclasses of an object creator in the client application, like the factory method pattern does.
* Avoid the inherent cost of creating a new object in the standard way (e.g., using the 'new' keyword) when it is prohibitively expensive for a given application.

To implement the pattern, declare an abstract base class that specifies a pure virtual clone() method. Any class that needs a "polymorphic constructor" capability derives itself from the abstract base class, and implements the clone() operation.
The client, instead of writing code that invokes the "new" operator on a hard-coded class name, calls the clone() method on the prototype, calls a factory method with a parameter designating the particular concrete derived class desired, or invokes the clone() method through some mechanism provided by another design pattern.

![](https://github.com/polurezov8/Patterns/blob/master/Prototype/Prototype.gif)

## Singleton

In software engineering, the singleton pattern is a software design pattern that restricts the instantiation of a class to one "single" instance. This is useful when exactly one object is needed to coordinate actions across the system. The term comes from the mathematical concept of a singleton.
Critics consider the singleton to be an anti-pattern in that it is frequently used in scenarios where it is not beneficial, introduces unnecessary restrictions in situations where a sole instance of a class is not actually required, and introduces global state into an application.

![](https://github.com/polurezov8/Patterns/blob/master/Singleton/Singleton.png)

## Factory Method

The Factory Method design pattern is one of the twenty-three well-known "Gang of Four" design patterns that describe how to solve recurring design problems to design flexible and reusable object-oriented software, that is, objects that are easier to implement, change, test, and reuse.

The Factory Method design pattern solves problems like:
* How can an object be created so that subclasses can redefine which class to instantiate?
* How can a class defer instantiation to subclasses?
Creating an object directly within the class that requires (uses) the object is inflexible because it commits the class to a particular object and makes it impossible to change the instantiation independently from (without having to change) the class.

The Factory Method design pattern describes how to solve such problems:
Define a separate operation (factory method) for creating an object.
Create an object by calling a factory method.
This enables writing of subclasses to change the way an object is created (to redefine which class to instantiate).
See also the UML class diagram below.

![](https://github.com/polurezov8/Patterns/blob/master/FactoryMethod/FactoryMethodPattern.png)
