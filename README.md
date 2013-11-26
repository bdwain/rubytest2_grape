rubytest2
=========

A simple Grape API that takes records as strings in a post request and returns them in different orders in different get requests

### Record Format

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. They can be in one of 3 formats

- Pipe Delimited (LastName | FirstName | Gender | FavoriteColor | DateOfBirth)
- Comma Delimited (LastName, FirstName, Gender, FavoriteColor, DateOfBirth)
- Space Delimited (LastName FirstName Gender DateOfBirth FavoriteColor)

### Usage

to start the server:

    bundle install  
    rackup
     
### Endpoints

- POST /records - Post a single record in any of the 3 formats
- GET /records/gender - returns records sorted by gender (female first) and then last name ascending
- GET /records/birthdate - returns records sorted by birthdate ascending
- GET /records/name - returns records sorted by last name descending

### Sample Output

    $ curl 'http://localhost:9292/records/gender'

[{"last_name" : "Hamm", "first_name" : "Mia","gender" : "Female", "favorite_color" : "Blue", "date_of_birth" : "6/15/1990"},{"last_name" : "Gretzky", "first_name" : "Wayne","gender" : "Male", "favorite_color" : "White", "date_of_birth" : "2/15/1968"},{"last_name" : "Jordan", "first_name" : "Michael","gender" : "Male", "favorite_color" : "Red", "date_of_birth" : "5/14/1988"},{"last_name" : "Ruth", "first_name" : "Babe","gender" : "Male", "favorite_color" : "Blue", "date_of_birth" : "4/15/1988"}]

    $ curl -d '{"line" : "Smith | Jon | Male | Blue | 5/15/1988"}' 'http://localhost:9292/records' -H Content-Type:application/json -v  

{"last_name" : "Smith", "first_name" : "Jon","gender" : "Male", "favorite_color" : "Blue", "date_of_birth" : "5/15/1988"}
