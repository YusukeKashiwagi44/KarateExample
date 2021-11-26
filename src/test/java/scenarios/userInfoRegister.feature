@ignore
Feature: User Info Regiseter
  Background:
    * url baseUrl

  Scenario: ユーザ情報登録
    Given path '/userInfoRegister'
    And request { id: 'A001', name: '太郎' }
    When method post

    Then status 200
    And match response == '#object'
    And match response.result == 'success'
