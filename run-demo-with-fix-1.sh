#!/bin/bash

CLASSPATH="$(IFS=':'; set -- lib/aopalliance-*.jar lib/guice-*.jar lib/gwt-*.jar lib/javax.inject-*.jar lib/json-*.jar lib/validation-api-*.jar demo/out/gin-classloader-demo.jar; echo "$*")"
java -cp "$CLASSPATH" org.example.gin.classloader.demo.GinBridgeClassLoaderDemo fix-1/out/gin-classloader-fix-1.jar lib/gin-*.jar
