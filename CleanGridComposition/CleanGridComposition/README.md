
# Clean Grid Composition, A Classified App

An app to list the popular ads from source powered by an open API Service.

It also facilitates the user to mark favorite and remove the favorite ad.

We allow user to add the items to bag and retain when landed back to app.
A dummy button with dismiss icon has been placed to app home page top left bar item to clear the cart table data for convenience.
 
Note: We do preserve selected ads list with CoreData storage for now.
 

## API Reference

#### Get all items

```http
  GET https://run.mocky.io/v3/5c138271-d8dd-4112-8fb4-3adb1b7f689e
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
|  |  |  |



## Authors

- [@nikhilnangia](https://www.github.com/nikhil0011)

## Tech Stack

**Client:** Swift, iOS

**Server:** REST API

 - Clean Priniciple with MVVM
 - App has been built following the principles of CLEAN architechture.
 - App has been layered into 3 different components Usecase, Presnter and main module using MVVM.
 - An internal core design system is used to style the ui components accross the app.
 - Styler is responsible for creating an multi attributed string (such as font, font size, kern, line height) and setting it accurate components.
 - Collection View added to main screen is backed up by an abstract internal data source layer which helps the implementing modules to reduce the boiler plate code and segregate the adapter code from view controller code.
 - Persistant storage is used to share core data context all over app.
 - Every entity is build with an repository pattern which provided access control for operation in form of managers to views.
 
## Running Tests

Tests for the following moduels have been added to project

- Service Class
- CoreDataManagers
**For Main Module::** 

- Data Source
- View Controller
- ViewModel
- Presenter Class

