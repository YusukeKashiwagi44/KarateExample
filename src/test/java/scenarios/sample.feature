# sample.feature
Feature: Karate Sample
  Background:
    * url baseUrl
    * def dataSet = read('data/testData.json')
    * def patternA_DataSet = get dataSet $[?(@.pattern == 'A')]
    * def patternB_DataSet = get dataSet $[?(@.pattern == 'B')]

  Scenario: 通常パターン
    Given path '/returnArgValue'
    And param arg = 'apple'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == 'apple'

  Scenario Outline: データ駆動パターン [<data>]
    Given path '/returnArgValue'
    And param arg = '<data>'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == '<data>'

    Examples:
      | dataSet |

  Scenario: 待機処理
    * def sleep =
      """
        function(pause){ java.lang.Thread.sleep(pause) }
      """
    Given path '/returnArgValue'
    And param arg = 'apple'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == 'apple'

    # 待機処理
    * def temp = sleep(10000);

    Given path '/returnArgValue'
    And param arg = 'banana'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == 'apple'

  Scenario: 別featureファイル呼び出し
    * def userInfoRegister = karate.callSingle('userInfoRegister.feature')

  Scenario Outline: データ駆動パターンA [<data>]
    Given path '/returnArgValue'
    And param arg = '<data>'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == '<data>'

    Examples:
      | patternA_DataSet |

  @normal
  Scenario: 通常パターン
    Given path '/returnArgValue'
    And param arg = 'apple'
    When method get

    Then status 200
    And match response == '#object'
    And match response.item == 'apple'

  Scenario: Java呼び出し
    * def strUtils = Java.type('scenarios.strUtils')

    Given path '/returnArgValue'
    And param arg = 'apple'
    When method get

    Then status 200
    * def upperStr = strUtils.upper(response.item)
    And match upperStr == 'APPLE'