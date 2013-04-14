# gin-classloader-demo

This code reproduces a problem while using gin within a custom classloader
and provides three possible solutions.

Running the GWT-Compiler within a classloader other than the system classloader may lead
to a very confusing error message stating that a gin-injector is supposedly not derived
from Ginjector. Cause for that is a comparison between classes from different classloaders
found in the following snippet from the `GinjectorGenerator` class:

    @SuppressWarnings("unchecked")
    // Due to deferred binding we assume that the requested class has to be a ginjector.
    private Class<? extends Ginjector> getGinjectorType(String requestedClass)
        throws ClassNotFoundException {

      // We choose not to initialize ginjectors since we do not require it for reflective analysis and
      // some people statically call GWT.create in them (which is illegal during Gin generator runs).
      Class<?> type = loadClass(requestedClass, false);
      if (!Ginjector.class.isAssignableFrom(type)) {
       throw new IllegalArgumentException("The type passed does not inherit from Ginjector - "
           + "please check the deferred binding rules.");
      }
    
      return (Class<? extends Ginjector>) type;
    }

More precisely it's the `Ginjector.class.isAssignableFrom(type)` comparison that fails.

I came up with a bunch of possible solution to the problem:

 1. Use the `GinBridgeClassLoader` that is also used to load the `type` to load the Ginjector interface
    instead of comparing against `Ginjector.class`.
 2. Use the own classloader (namely `GinBridgeClassLoader.class.getClassLoader()`) as
    parent classloader of the `GinBridgeClassLoader`.
 3. Use the current thread context classloader as parent classloader of the `GinBridgeClassLoader`

The first solution would be my personal best guess to be the Right Thing (TM). While the second one works
even if the thread's context classloader is set incorrectly, gwt uses the thread's context classloader to
load the module descriptors (and most probably all other resources) thus the third seems still prefarable
over the second.


## Build

You can use Maven as well as Ant to build the project.


### Maven

To build the project simply run from the project root

    mvn package

To run the demo run

    mvn verify

The provided fixes are selectable via profiles. To run the Demo with the first applied run

    mvn verify -P fix-1

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

    ant

there is a bunch of shell scripts to run the demo afterwards (namely `run-demo.sh` and `run-demo-with-fix-[123].sh`).


# License
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
