# Bostagram
Bosta Technical Task

## Installation

All third-parties used, are installed using swift package manager it should be worked without any extra installation. if you faced an build error just build clean the project the try again

## Project Structure

The architecture is MVVM with clean architecture which contain the following layers

- Presentation Layer 'view and viewModel'
- Domain Layer 'entities and Use Case'
- Data Layer 'Repository, network, and persistent data if needed'
- Navigator to handle modules navigation and initialization

## Data Flow

- In the presentation layer the view will send action to viewModel and the view model to talk to the correspoding use case and reply to view
- Use case will talk to repository layer to get the required data and send it back to the use case
- The repository will talk to the remote server if the requested data is on the server, or will call local storage if it exists on the local storage

## Binding

- The binding between the presentation layer component is done using FRP RXswift
- The binding between th use-case and the viewModel is done using FRP RXswift
- The binding between the Data layer and the domain is done using clourses, to be more dynamic structure, this will give us the ability to use the data layer with any other archecture i.e. VIPER or even we might migrate to use swift combine, so it will save us some work. It might be also used in other project
- The binding between Repository and the network is done using clourses
