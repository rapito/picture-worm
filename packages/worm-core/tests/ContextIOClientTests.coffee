class ContextIOClientTests

  client: null

  describe 'ContextIOClient', ->
    beforeAll (test) ->
      client = @Cio

    beforeEach (test) ->
    afterEach (test) ->
    afterAll (test) ->

    it 'should be constructed', (test) ->
      console.log 'should be constructed'
      expect(CioC).to.be.an.instanceof(ContextIOClient);

Munit.run(new ContextIOClientTests())