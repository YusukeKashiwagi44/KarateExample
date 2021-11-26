# mock.feature
Feature: Mock Server
  Background:
    * def userInfo =
    """
    [
      {id: 'A001', name: '太郎', result: 'success'},
      {id: 'A002', name: '二郎', result: 'error'},
      {id: 'A003', name: '三郎', result: 'error'},
    ]
    """

# -----------------------------------------------
# リクエストパラメータargの値を返す { "item":"(argの値)" }
# GET:/returnArgValue
# -----------------------------------------------
  Scenario: methodIs('get') && pathMatches('/returnArgValue')
    * print requestParams
    * print paramValue('arg')
    * def value = paramValue('arg')
    * def response = { "item":'#(value)' }

# -----------------------------------------------
# ユーザ情報登録
# userInfo内の該当IDに応じた結果を返す
# POST:/userInfoRegister
# -----------------------------------------------
  Scenario: methodIs('post') && pathMatches('/userInfoRegister')
    * def requestBody = request
    * def id = requestBody.id
    * print 'id : ' + id
    * def target = karate.jsonPath(userInfo, "$[?(@.id=='" + id + "')]")[0]

    # userInfoに該当のものがなかった場合、エラーを返す
    * eval if (target == null) karate.set('responseStatus', 400)
    * eval if (target == null) karate.abort()

    # resultがerrorの場合、400エラーを返す
    * eval if (target.result == 'error') karate.set('responseStatus', 400)
    * eval if (responseStatus == 400) karate.abort()

    # 以外はsuccessとして正常応答を返す
    * def response = {result : 'success'}

