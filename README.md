# CurrantWeatherApp

# Clean-Architecture-with-MVVM
In this , we will see how we implement a Clean architecture for our iOS application . 
iOS Project implemented with Clean Layered Architecture and MVVM.

![CleanArch](https://user-images.githubusercontent.com/46462169/151868540-3941aa85-66aa-4f74-85eb-6c0cdcc994fd.png?raw=true "Clean Architecture Layers")


# Clean Architecture :

Achieve a high-level separation of concerns by layering. Clean Architecture looks like a very carefully thought and effective architecture. It makes the big leap of recognizing the mismatch between Use Cases and Entities and puts the former in the driving seat of our system.it also aims for a maximum independence of any frameworks or tools that might stay in the way of application’s testability or their replacement.


* Entities: Which Contain Enterprise-wide Business Rules. 
* Use Cases: Which Contain Application-specific Business Rules. 
* Interface Adapters: Which Contain Adapters To Peripheral Technologies. Here, You Can Expect MVC, Gateway Implementations 
* Frameworks & Drivers: Which Contain Tools Like Databases Or Framework. By Default, You Don’t Code Too Much In This Layer, But It’s Important To Clearly State The Place And Priority That Those Tools Have In Your Architecture.


# Benefits of a Clean Architecture :
- Flexible
- Testable
- Easy to understand
- High Maintainability
- Screaming – Use Cases are clearly visible in the project’s structure

# When to Use Clean Architecture : 

When to Use Clean Architecture :  Is the team skilled and/or convinced enough
Will the system outlive major framework releases?
Will the system outlive the developers and stakeholders employment?

# Technical notes:
- MVVM - My preferred architecture.
    - MVVM stands for “Model View ViewModel”
    - It’s a software architecture often used by Apple developers to replace MVC. Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
- Models hold application data. They’re usually structs or simple classes.
- Views display visual elements and controls on the screen. They’re typically - subclasses of UIView.
- View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.
![MVVMPattern](https://user-images.githubusercontent.com/46462169/151869796-e52e3d96-90a4-4349-900e-d7b7cb78bc0f.png)

## Layers
* **Domain Layer** = Entities + Use Cases + Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + DB
* **Presentation Layer (MVVM)** = ViewModels + Views

**Note:** **Domain Layer** should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

# App Goal:
* This project was intended to work as a Build a simple weather app that displays the current weather and hourly weather forecast for a specific location, allowing users to switch between Celsius (°C) and Fahrenheit (°F) demo projects for iOS using Swift. 
* The demo uses the [Weather API](https://api.open-meteo.com) which returns information in a JSON format.
* Use of List View to display  Weather list information.
* Use of **Observable** for Reactive programming.

## Requirements:
* iOS 13.0+
* Xcode 15.0+
* Swift 5

# License
Distributed under the MIT License. Copyright (c) 2022 Abdelrahman Ahmed Shawky
