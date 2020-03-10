# OpenWeatherApp
This code was written by Niv Ben-Porath


Known issues and bugs
* error messages should be displayed to the user. Currently they are only printed

Cities List Screen:
* acts as a main view for initializing the Table and Collection view.
* initiats the wether fetch action
* toggles the screen between list and grid


Notes:
* UI is implemented in code
* Custom views were used from an SPM I wrote - https://github.com/nbpapps/MyViewsCustomized 

Known Issues
* Data was saved to core data. The implementation was done with only two entities with no relations between them. A different approch could have been to create a City entity and have a relation to a Weather entity for the current weather and also a relation between City and a Forecast entity. The Forecast entity could also have a relation to an array of Weather entities (for the 5 days)

*  Implementation for the case for not getting a "day of the week" (in CityForecastViewModel) is missing 

* All errors are handled. They are not presented in the UI

* loading indecators need to be added

* UI bug where the next 5 days cells are not adjusting to different screens



