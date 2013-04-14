#!/bin/bash

#  Copyright 2012 Eric Karge (eric.karge@hypoport.de)
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

CLASSPATH="$(IFS=':'; set -- lib/aopalliance-*.jar lib/guice-*.jar lib/gwt-*.jar lib/javax.inject-*.jar lib/json-*.jar lib/validation-api-*.jar demo/out/gin-classloader-demo*.jar; echo "$*")"
java -cp "$CLASSPATH" org.example.gin.classloader.demo.GinBridgeClassLoaderDemo lib/gin-*.jar
