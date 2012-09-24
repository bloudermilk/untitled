Feature: New

  The `untitled new` command initializes a new Untitled project.

  Scenario: Creating a vanilla application
    When I run `untitled new my_app`
    Then a directory named "my_app" should exist
    When I cd to "my_app"
    Then the following files should exist:
      | config.ru  |
      | config.yml |
