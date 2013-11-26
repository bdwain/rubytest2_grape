rubytest2
=========

A simple tool to process records from files, combine them into one set of records, and output them sorted by various fields.

### File Format

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. They can be in one of 3 formats

- Pipe Delimited (LastName | FirstName | Gender | FavoriteColor | DateOfBirth)
- Comma Delimited (LastName, FirstName, Gender, FavoriteColor, DateOfBirth)
- Space Delimited (LastName FirstName Gender DateOfBirth FavoriteColor)

A file is just a set of formatted lines

### Usage

    bundle install
    ruby main.rb <file1> <file2> <file3> ....

### Sample Output

$ ruby main.rb test1 test2 test3  
Records sorted by gender and then last name ascending:  
Hamm Mia Female 6/15/1990 Blue  
Obama Michelle Female 1/17/1964 Green  
Gretzky Wayne Male 2/15/1968 White  
Jordan Michael Male 5/14/1988 Red  
Lincoln Abraham Male 2/25/1810 Blue  
Obama Barack Male 8/4/1961 Blue  
Ruth Babe Male 4/15/1988 Blue  
Washington George Male 2/15/1728 Red  

Records sorted by birth date ascending:  
Washington George Male 2/15/1728 Red  
Lincoln Abraham Male 2/25/1810 Blue  
Obama Barack Male 8/4/1961 Blue  
Obama Michelle Female 1/17/1964 Green  
Gretzky Wayne Male 2/15/1968 White  
Ruth Babe Male 4/15/1988 Blue  
Jordan Michael Male 5/14/1988 Red  
Hamm Mia Female 6/15/1990 Blue  

Records sorted by last name descending:  
Washington George Male 2/15/1728 Red  
Ruth Babe Male 4/15/1988 Blue  
Obama Barack Male 8/4/1961 Blue  
Obama Michelle Female 1/17/1964 Green  
Lincoln Abraham Male 2/25/1810 Blue  
Jordan Michael Male 5/14/1988 Red  
Hamm Mia Female 6/15/1990 Blue  
Gretzky Wayne Male 2/15/1968 White  

