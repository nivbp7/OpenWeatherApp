# OpenWeatherApp
This code was written by Niv Ben-Porath

Cities List Screen:
* acts as a main view for initialising the Table and Collection view controllers as child VCs
* initiates the wether fetch action 
* toggles the screen between list and grid
* fetches saved weather info from core data
* both table view and collection view are ‘driven’ by view models and a dedicated data source

City Forecast screen:
* initialises the Future forecast table view controller as a child VC
* fetches the city forecast, only if an update is required (if we don’t have this city’s forecast or that the current day has changed from the last time we got the data)
* shows the table view controller when data 

Data Fetch:
* gets the data from the api (via Moya), parse the data and save to core data



Notes:
* UI is implemented in code
* Custom views were used from an SPM I wrote - https://github.com/nbpapps/MyViewsCustomized 


Known Issues
* Data was saved to core data. The implementation was done with only two entities with no relations between them. A different approach could have been to create a City entity and have a relation to a Weather entity for the current weather and also a relation between City and a Forecast entity. The Forecast entity could also have a relation to an array of Weather entities (for the 5 days)

*  Implementation for the case for not getting a "day of the week" (in CityForecastViewModel) is missing 

* All errors are handled. They are not presented in the UI

* loading indicators need to be added

* UI bug where the next 5 days cells are not adjusting to different screens




