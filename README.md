
# Moneybox iOS Technical Challenge


## Implementation

- MVVM+C design pattern used with parent AppCoordinator and coordinators for the 3 main flows: Login, Accounts and Detail.
- Adherance to SOLID principles
- UIKit and autolayout used throughout

## Additional features

- Additional product information displayed within detail page
- Logout button on Accounts screen navigation bar with user confirmation
- Custom stack for information display with options for sublabels and button handling
- Token timeout after 5 minutes returning user to login page
- Dark and light appearance

## Next steps

If I were to take this project further I'd like to implement the following:

- Custom error message display
- Pin login alternative
- Animations for accounts screen welcome
- Tab bar integration
- Migration to async for networking requests
- Localisable strings for preferred languages


## The Brief

To create a 'light' version of the Moneybox app that will allow existing users to login and check their account balance, as well as viewing their Moneybox savings. 
- To clone this repository into your private repository and implement the solution.
 
### The app should have
- A login screen to allow existing users to sign in
- A screen to show the accounts the user holds, e.g. ISA, GIA
- A screen to show some details of the account, including a simple button to add money to its moneybox.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint provided, and the account's Moneybox amount would be updated.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 - **Showcase what you can do. It can be a refined UI, or enhanced UX, or use of specific design patterns in the code, or anything that can make the project stand out.**
 - Demonstration of coding style, conventions and patterns.
 - A tidy code organisation.
 - Use of autolayout and UIKit.
 - Implementation of unit tests.
 - Any accessibility feature would be a bonus.
 - The application must run on iOS 15 or later.
 - Any 3rd party library should be integrated using Swift Package Manager.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking module of the project.

#### Base URL & Test User
The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`. </br>
You can log in using the following user:

|  Username          | Password         |
| ------------- | ------------- |
| test+ios@moneyboxapp.com  | P455word12  |

#### Authentication
You should obtain a bearer token from the Login response, and attach it as an Authorization header for the endpoints. Helper methods in the API/Base folder should be used for that.
(Note: The BearerToken has a sliding expiration of 5 mins).

| Key  |  Value  |
| ------------- | ------------- |
| Authorization |  Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

#### API Call Hint

```
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
request: Initialize your request model </br>
Completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests folder includes stubbed data to easily mock the responses needed for unit testing

#### Usage Hint
You can create a DataProviderMock class via inject DataProviderLogic protocol </br>
You can mock response in Login.json file like this:
```
StubData.read(file: "Login", callback: completion)
```

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.
 - (Optional) Provide a readme in markdown which outlines your solution.

## Good luck!
