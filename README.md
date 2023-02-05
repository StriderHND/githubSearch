# GitHubSearch

Welcome to the GitHubSearch App demo.

In this demo I show some of my development skills using some of Apple's techonoliges.

## Stack

This App is develop using the following technonlogies:
 
* **Swift** 
* **SwiftUi** 
* **Combine**
* **Async/Await**

## Instalation
Close the repository using **SSH** on lo local box, there is no need to install third-party package managers and libraries.

## Architecture
This app is using as pricipal pattern design patter **MVVM** (Model-View-ViewModel) to separte buisness logic and interface controls this alogn side Apple's **Combine** framework, Combine beign a **first citizen fuctional reactive framework** is the main core of this application with the usage of **Dependency Inyection** (D.I).


### Folder Structure
For navigation propuses the app is developed in the following folder structure

> **Root** folder: where all groups and other general files are located
> 
> **Backend**: All the models, services layers are located in this file, also extension to specific DataTypes that need custom functions to help to plug specific functionality
> > **DataType + Extensions**: Extensions for DataTypes that not support specific functionality here is where all those data types are extended.
> > 
> > **Services**: Services all services layers should be create here example: Network Services, Account Services, Security 
> > 
> > **Models**: Struct files that represent objects been **value types** most of them are used to represent data comming from the APIs and use this models to represent information for the user in the UI


> **Frontend**: All UI componets and views are located in this folder along side the ViewModels of each view, and global App UI componenets that can be shared across the app
> > **Views**: This is were all the views along side the ViewModels of each view are placed.
> > 
> > **Components**: All reusable componenet that could be used in multiple places in the app will be located here.
