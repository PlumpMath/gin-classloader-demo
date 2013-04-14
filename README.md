# gin-classloader-demo

This code reproduces a problem while using gin within a custom classloader
and provides three possible solutions.


## Build

You can use Maven as well as Ant to build the project.


### Maven

To build the project simply run from the project root
> mvn package

To run the demo run
> mvn verify

The provided fixes are selectable via profiles. To run the Demo with the first applied run
> mvn verify -P fix-1

The same goes for the second and third fix.


### Ant

Before you can run the Ant build you need to put the following jars into the "lib" directory in the project root

 * aopalliance-1.0.jar
 * gin-2.0.0.jar
 * guice-3.0.jar
 * guice-assistedinject-3.0.jar
 * gwt-dev-2.5.1.jar
 * gwt-user-2.5.1.jar
 * javax.inject-1.jar
 * json-20090211.jar
 * validation-api-1.0.0.GA.jar
 * validation-api-1.0.0.GA-sources.jar

To build the project just run ant
> ant

there is a bunch of shell scripts to run the demo afterwards (namely
     run-demo.sh
and
     run-demo-with-fix-[123].sh
).

License
-------
     Copyright 2012 Eric Karge

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
