# JARVIS-one 
A JARVIS-inspired app that uses MARVEL's developer API to fetch any Comic you want
## 👋 by: Marcos J Reyes
*Positively impacting the world one line of code at a time.*

## Requirements
- XCode min version: 13.0 (13A233)
- Cocoapos CLI: [https://guides.cocoapods.org/using/getting-started.html](https://guides.cocoapods.org/using/getting-started.html)
- Apple Developer Account: [https://developer.apple.com/programs/](https://developer.apple.com/programs/)
- MARVEL's Developer API Keys: [https://developer.marvel.com/](https://developer.marvel.com/)

## Getting started
1. Clone this repo
2. Open `JarvisOne.xcworkspace`; ⚠️ NEVER open the `.xcodeproj` file
3. Select the iOS target (either scheme is ok for now)
4. Perform a project clean (CMD+SHIFT+K)
5. Build Project (CMD+B)
	- If you encounter an error stating `Exit code -1` or an error about certain libraries `Not Found`, please open terminal, go to the project directory and at the level where your `Podfile` is located, run `pod install`
    - Clear Derived Data
	- Clean project again and re-build
6. Open `ComicDetailVMTests.swift` and enter your respective Public and Private MARVEL Developer Keys (This is only needed if you plan on running Unit Tests on your own)
7. The app will ask you to enter Public and Private keys, which it saves into your keychain

## Cool Comic ID to start from
65285

## Essentials
- MVVM patter as base, using the concept of Router from VIPER architecture via Coordinators; always keeping SOLID principles in mind
- Vast use of modularized services and extensions
- Written in Swift 5
- UIKit used for the Core and iOS (Though no dependencies on Storyboards)
- RxSwift + RxCocoa for Reactive approach
- XCtests for Unit and UI Testing
- Libraries via cocoapods

## Features so far
- Light and Dark Mode supported
- Localization supported (English and Spanish for now)
- Coordinator Pattern to easily trigger any User flow from anywhere while maintaing Dependency Inversion
- Protocol driven ViewModels that allow for very clear logic and expected behaviors
- Automatic Retry Logic at the API Networking Class

## Project Structure and its importance
The project is essentially divided in `Core` and `iOS` as of now.
As it grows, we can easily add a `tvOS` folder for example, and tvOS-specific files can be there.
The important aspect to note is that in the `Core` everything from Models, to Formatters, to ViewModels, to Extensions ,to Protocols, etc is shared from there across targets. 
This allows for efficient development and faster scalibility.
Components like the StyleGuide also intertwine with Extensions to be able to do tasks like re-branding or UI-tweaks or completely new User flows in a fraction of the time.