# Command Line Weather Forecaster

## Setup

* clone down this repository
* within the main directory `touch .config.yml`
* within the `.config.yml` file input the following:
  ```
  ZIPCODE_API: <your api key for the zipcode api>
  DARKSKY_API: <your api key for the darksky api>
  ```

## To Run

* navigate to the root directory of the app on the command line
* granularity options include "currently", "minutely", "hourly", "daily" in those exact formats
* type `ruby lib/forecaster.rb <insert zipcode> <insert a granularity> <insert path/to/file relative to app directory>`

  * this query, `ruby lib/forecaster.rb 80210 hourly denver_hourly_weather.txt`, would return a file at the root app   
  directory with the hourly denver weather

* if you included a file that file will have the requested info and a message will display for a successful write
* if you did not include a file the requested info will be outputted to the console
* if there was an error you will be notified
