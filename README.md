# SP technical exercise.

## Description

```
	Firstly, the test should take you no more than 2.5 hours to complete.
	Secondly, the test is for us to see how you code and the methodologies you use, what we will be
	looking for in this test are the following:

	* Functionality
	* Efficiency – We like clean, simple code.
	* Readability
	* Tests (we have 96% test coverage in our code and we aim to keep it that way).

	Also, we would like to understand your ability to use TDD and OO, so please ensure
	these are part of your complete test. This is your chance to show us what you can do,
	so use it to show us how you design and code!

	Feel free to submit your solution as a link to your version control repository.


	Write a ruby script that:
	* Receives a log as argument (webserver.log is provided)
	e.g.: `./parser.rb webserver.log`
	* Returns a list of webpages with most page views ordered from most pages views to less page views
	`e.g.: /home 90 visits /index 80 visits etc...` 
	* list of webpages with most unique page views also ordered
	e.g.: `/about/2 8 unique views /index 5 unique views etc...`
```

## Usage 

`$ ./bin/parser.rb ./src/webserver.log` will output most visited pages in the webserver.log file, which is the default option. It is analogous to `$ ./bin/parser.rb ./src/webserver.log -p`. Add 'u' to make the results unique, e.g. `$ ./bin/parser.rb ./src/webserver.log -pu`. 

The following does the same, but with unique IP adressess. 
`$ ./bin/parser.rb ./src/webserver.log -i` and `$ ./bin/parser.rb ./src/webserver.log -iu` will output unique hits by IP. 
To run the tests `$ bundle exec rspec`. 

Or via Docker compose: `docker-compose run --rm rspec`.

