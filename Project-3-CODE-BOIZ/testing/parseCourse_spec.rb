# File created 10/05/2019 by Andrew Petrilli

require 'rspec'
require_relative '../src/parseCourse'

describe 'parse tests' do

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse courses' do
    parsed_data = JSON.parse '
      {
        "data": {
          "courses": [
            {
              "course": {
                "title": "Computer Science and Engineering Research for Thesis",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Naeem Omar Shareef"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    '
    courses = ParseCourse.get_courses parsed_data["data"], "Naeem Omar Shareef"
    expected_result = ["CSE 4999: Computer Science and Engineering Research for Thesis"]
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse courses wrong instructor' do
    parsed_data = JSON.parse '
      {
        "data": {
          "courses": [
            {
              "course": {
                "title": "Computer Science and Engineering Research for Thesis",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Naeem Omar Shareef"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    '
    courses = ParseCourse.get_courses parsed_data["data"], "arbitrary instructor"
    expected_result = []
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse no courses' do
    parsed_data = JSON.parse '
      {
        "data": {
          "courses": []
        }
      }
    '
    courses = ParseCourse.get_courses parsed_data["data"], "arbitrary instructor"
    expected_result = []
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse courses 2 courses' do
    parsed_data = JSON.parse '
      {
        "data": {
          "courses": [
            {
              "course": {
                "title": "Basket Weaving",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Andrew Petrilli"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "course": {
                "title": "How to get an A",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Andrew Petrilli"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    '
    courses = ParseCourse.get_courses parsed_data["data"], "Andrew Petrilli"
    expected_result = ["CSE 4999: Basket Weaving", "CSE 4999: How to get an A"]
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse open courses' do
    raw_data = '
      {
        "data": {
          "courses": []
        }
      }
    '
    HTTPRequest.any_instance.stub(:isClassOpen).and_return("")
    courses = ParseCourse.get_open_courses raw_data
    expected_result = {}
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse open courses is open' do
    raw_data = '
      {
        "data": {
          "courses": [
            {
              "course": {
                "title": "Computer Science and Engineering Research for Thesis",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "section" : 1111,
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Naeem Omar Shareef"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    '
    stub_return = '
      {
        "data": {
          "availability": {
            "isOpen": true
          }
        }
      }
    '
    HTTPRequest.any_instance.stub(:isClassOpen).and_return(stub_return)
    courses = ParseCourse.get_open_courses raw_data
    expected_result = {"4999" => [1111]}
    expect(courses).to eq expected_result
  end

  # Created on 10/05/2019 by Andrew Petrilli
  it 'test parse open courses not open' do
    raw_data = '
      {
        "data": {
          "courses": [
            {
              "course": {
                "title": "Computer Science and Engineering Research for Thesis",
                "subject": "CSE",
                "catalogNumber": "4999"
              },
              "sections": [
                {
                  "section" : 1111,
                  "meetings": [
                    {
                      "instructors": [
                        {
                          "displayName": "Naeem Omar Shareef"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    '
    stub_return = '
      {
        "data": {
          "availability": {
            "isOpen":false
          }
        }
      }
    '
    HTTPRequest.any_instance.stub(:isClassOpen).and_return(stub_return)
    courses = ParseCourse.get_open_courses raw_data
    expected_result = {}
    expect(courses).to eq expected_result
  end
end