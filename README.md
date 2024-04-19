# RemoteDataExplorer
iOS application that retrieves data from two remote servers and displays it in a user-friendly interface. It fetches data from two different URLs containing JSON data and parses it accordingly. The parsed data includes information about companies, products, catch phrases, daily revenue, and color descriptions.

## Features
- Fetches JSON data from two remote servers.
- Parses JSON data to extract relevant information.
- Displays company name, product name with version, catch phrase, daily revenue, and color descriptions in the user interface.
- Supports navigation between different companies' data.

## Installation
To run this application, ensure you have Xcode installed on your macOS device. Follow these steps:
1. Clone or download this repository.
2. Open the `JonesSpencer_RemoteData.xcodeproj` file using Xcode.
3. Build and run the project on the iOS Simulator or a physical iOS device.

## Usage
Upon launching the app, it retrieves data from two remote servers asynchronously. The user interface displays the details of the first company by default. You can navigate between different companies' data by tapping on the "Next" and "Previous" buttons.

## File Structure
The project consists of the following files:
- `ViewController.swift`: Contains the main view controller class responsible for handling UI and data retrieval logic.
- `Company.swift`: Defines the `Company` class to represent company information.
- `Product.swift`: Defines the `Product` class to represent product information.
- `ColorData.swift`: Defines the `ColorData` class to represent color information.

## Technologies Used
**Swift Programming Language**: Used for developing the application logic and UI.
**UIKit Framework**: Provides the essential infrastructure for constructing and managing iOS user interfaces.
**Foundation Framework**: Provides a base layer of functionality for your app, including data storage, networking, and more.
**Xcode IDE**: Integrated development environment used for coding, debugging, and deploying iOS applications.
**URLSession**: Used for making network requests and fetching data from remote servers.
**JSONSerialization**: Utilized for parsing JSON data retrieved from the remote servers.

## Json Data Structures 
**The JSON data provided for this application was obtained from Full Sail University.**
https://fullsailmobile.firebaseio.com/T1NVC.json
```json
[
  {
    "company": "String",
    "name": "String",
    "version": "String"
  }
]
```
https://fullsailmobile.firebaseio.com/T2CRC.json
```json
{
  "catch_phrase": "String",
  "colors": [
    {
      "color": "String",
      "description": "String"
    },
    {
      "color": "String",
      "description": "String"
    }
  ],
  "daily_revenue": "String"
}
```

### You can contribute by:
-  Reporting bugs
-  Suggesting new features
-  Submitting pull requests to improve the codebase
