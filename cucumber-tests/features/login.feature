Feature: Login 
  As a mobile user
  I want to use Coupa app
  So that I can Login

Scenario Outline: login
  Given I login using "<Username>" and "<Password>"
  Then I should see "<Result>"
  And I tap "History"
  Then I should see "No Historical Approvals Found!"


@android
Scenarios: 
  | Username     | Password      | Result    |
  | coupa2091    | coupa123      | Approvals |
  | coupaSupport | CoupaSupport1 | Approvals |
 
