Feature: Login 
  As a mobile user
  I want to use Coupa app
  So that I can Login

Scenario Outline: login
  Given I login using "<Username>" and "<Password>"
  Then I should see "<Result>"


@android
Scenarios: 
  | Username     | Password      | Result |
  | coupaSupport | CoupaSupport1 | Approvals |
 