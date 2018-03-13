component {
    property beanFactory;

    function getInstance( name, dsl, initArguments, targetObject ) {
        var beanName = isNull( dsl ) ? name : dsl;
        return beanFactory.getBean(
            beanName = beanName,
            constructorArgs = initArguments
        );
    }
}