# GitHubSearch

Welcome to the GitHubSearch App demo.

In this demo, I show some of my development skills using some of Apple's technologies.

## Stack

This App is developed using the following technologies:
 
* **Swift** 
* **SwiftUi** 
* **Combine**
* **Async/Await**


## Instalation
Close the repository using **SSH** on lo local box, there is no need to install third-party package managers and libraries.

## Architecture
This app uses a principal pattern design pattern **MVVM** (Model-View-ViewModel) to separate business logic and interface controls alongside Apple's **Combine** framework, Combine being a **first citizen functional reactive framework** is the core of this application with the usage of **Dependency Injection** (D.I).


### Folder Structure
For navigation purposes, the app is developed in the following folder structure.

> **Root** folder: where all groups and other general files are located.
> 
> **Backend**: All the models, and services layers are located in this file, also an extension to specific DataTypes that need custom functions to help to plug specific functionality.
> > **DataType + Extensions**: Extensions for DataTypes that do not support specific functionality here are where all those data types are extended.
> > 
> > **Services**: Services all services layers should be created here an example: Network Services, Account Services, Security.
> > 
> > **Models**: Struct files that represent objects are **value types** most of them are used to represent data coming from the APIs and use these models to represent information for the user in the UI.

> **Frontend**: All UI components and views are located in this folder alongside the ViewModels of each view and global App UI components that can be shared across the app.
> > **Views**: This is where all the views alongside the ViewModels of each view are placed.
> > 
> > **Components**: All reusable components that could be used in multiple places in the app will be located here.
