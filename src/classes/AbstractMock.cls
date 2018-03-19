public abstract with sharing class AbstractMock implements System.StubProvider {

  public static final String UNIMPLEMENTED_METHOD = '{0} must be implemented.';

  public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType,
      List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {

    return callMockedMethod(stubbedMethodName, listOfArgs);
  }

  protected UnsupportedOperationException newUnsupportedMethodException(String methodName) {
    return new UnsupportedOperationException(String.format(UNIMPLEMENTED_METHOD, new String[] { methodName }));
  }

  protected abstract Object callMockedMethod(String stubbedMethodName, List<Object> listOfArgs);
}