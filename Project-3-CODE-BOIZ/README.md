# Project 3
### Web Scraping
Our project gathers data from the OSU CSE faculty directory (https://cse.osu.edu//about-us/faculty) and the OSU course library (https://classes.osu.edu/class-search/#/) and makes a webpages that tells you 
which courses each faculty member teaches. The user can specify several parameters at runtime to change which courses are fetched. Additionally, the user can specify whether they would like to have the course list emailed to them.

## How to use it
NOTE: You may need to wait for up to a minute for the website to scrape, and for the email output to be sent.

Before running the program, run `bundle install` in the project directory to ensure that necessary gems are installed.

To use the program, run `Main.rb`. At runtime, the user will be asked a series of questions to tune the query, including:
- whether the user wants to see autumn 2019 or spring 2020 courses
- and whether the user wants to see only open courses or open AND closed courses

Finally, after a short period (after the data is scraped), the user will be prompted to enter their email address. If the user enters a valid address, they will be mailed a course list. If they do not enter anything, no email will be sent.

After the program is run, the user can use Firefox to open the HTML output in the root directory of the project folder (`output.html`). The output file only displays professors that are teaching courses that were matched by the search query. For each professor, the user can see:
- an image of the professor
- the professor's name, hyperlinked to their webpage (if it exists)
- and the list of courses they are teaching based on the search query, hyperlinked to the corresponding course syllabus

### Roles
* Overall Project Manager: Sean Simpson
* Coding Manager: Neil McKibben
* Testing Manager: Andrew Petrilli
* Documentation: Zach Venables

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

Sean Simpson: Added e-mail functionality

Neil McKibben: Scraped information from course directory

Matthew Kelch: Produced HTML template using ERB (`output.html.erb`), combined data to send to the ERB template (`Output.rb`), used CSS to style the HTML (`output.css`), tweaked e-mail output to send all professors' data matching the query

Zach Venables: Scraped instructor pages for, names, pictures, and website links. Completed README.

Andrew Petrilli: Parsed raw information from course page into usable chunks (i.e return list of course names/number/description)
                 Created method that returns a hash where key is 
                 course and value is array of sections that are open for the course
