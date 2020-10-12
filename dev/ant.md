<!-- vimvars: b:markdown_embedded_syntax={'bash':'','sh':'bash','xml':''} -->
# Ant

## Running

Default project file: `build.xml`.

Printing useful information about ant settings and environment:
```bash
ant -diagnostics ...
```

Verbose option for printing information about run commands:
```bash
ant -v ...
```
Will print for instance the compiler option values (classpath, sourcepath, etc.).

Setting Ant properties at command line:
```bash
ant -Dproperty=value ...
```

Setting arguments in environment:
```bash
export ANT_ARGS=-logger org.path.MyLogger
```

## Tags

### Project

Project declaration:
```xml
<project name="ant-doc" default="default-target">
</project>
```
The default attribute is used to set the default target.

Get project directory path:
```xml
<project name="myproj">
	<dirname property="this.dir" file="${ant.file.myproj}"/>
</project>
```

#### Basedir
 TODO test what is working dir or current dir with basedir=".".
```xml
<project name="fr.cea.climb.db" default="all" basedir=".">
</project>
```

## Recursive calls

### Ant

```xml
<ant dir="some.dir" inheritAll="false"/>
<ant dir="some.dir" target="my.target" inheritAll="false"/>
```
The parameter `inheritAll` (set to `true` by default) sends all the properties of the current project to the project on which ant is called.
The parameter `target` runs the specified target instead of the default target.

### Subant

```xml
<subant target="jar">
	<dirset dir="${root.dir}" includes="java-lib" />
</subant>
```

### Antcall

Can call the same target several times:
```xml
<antcall target="mytarget"/>
<antcall target="mytarget"/>
```

Run in a new project, heritating current properties by default. But since it runs in a separate space (new project), any new created property will be eliminated when terminating. So it's useful when one want run targets for different mode like debug and release:
```xml
<target name="all">
	<antcall target="debug"/>
	<antcall target="release"/>
</target>
```

## import

Import another ant file into the current one.
Contrarily to include task, if "as" attribute isn't supplied, all targets will be merged into current project, without prefix.

```xml
<project name="proja">
	<import file="somedir/to/another/file.xml"/>
</project>
```

## include

Like import task, except it prefixes all imported targets by the value of the "as" attribute if present, and by the name of the imported project if not present.

## target

Defining dependencies for a target:
```xml
<target name="my.target" depends="some.other.target,and.another.one"/>
```

Running a target only if a value is true or false:
```xml
<target name="my.target" if="${my.property}"/>
<target name="my.target" unless="${my.property}"/>
```

To list all availabe targets inside a project, run:
```bash
ant -p
```

## property

Defining a property:
```xml
<property name="namespace.file" value="NAMESPACE"/>
```

Testing if a file exists:
```xml
<available file="my/file/or/dir" property="my.file.is.present"/>
```

## Built-in properties

 * See `getProperties()` method in [System](http://docs.oracle.com/javase/1.5.0/docs/api/java/lang/System.html) class.
 * [Properties and built-in properties](https://ant.apache.org/manual/properties.html).

New line character:
```xml
<... "${line.separator}"/>
```

File/Dir separator:
```xml
<... "${file.separator}"/>
```

## path

Defining a path:
```xml
<path id="mypath">
	<pathelement location="some/path"/>	
	<pathelement location="someother/path"/>	
	<path refid="somepath_reference"/>
	<fileset dir="somedir" includes="*.jar"/>	
	<dirset dir="somedir" includes="somesubdir"/>	
</path>
```

Setting a property value to a path:
```xml
<property name="mypath" refid="somepathid"/>
```
Path elements are separated by the current OS separator.

Making a path string for a specific os:
```xml
<pathconvert targetos="windows" property="mypath" refid="mypathrefid"/>
```

Making a path using specific separator:
```xml
<pathconvert property="deps" pathsep="${line.separator}">
	<path refid="fr.cea.deltadore.jars.release"/>
</pathconvert>
```

## condition

```xml
<condition property="myprop" value="value_if_true" else="value_if_false">
	<!-- some conditions -->
</condition>
```

## File system

Make a directory:
```xml
<mkdir dir="my.dir"/>
```

Copying one file:
```xml
<copy file="essai.md" tofile="tmp.md"/>
```

Copying files:
```xml
<copy todir="destination_dir">
	<fileset dir="${src.dir}" excludes="**/*.java"/>
</copy>
```
By default, it will preserve directory structure of sources files.

Copying a directory:
```xml
<copy todir="path/to/new_dir_name">
	<fileset dir="src_dir"/>
</copy>
```

Deleting files:
```xml
<delete dir="my_directory"/>
<delete dir="my_fct_files" includes="*.test_output"/>
```

Listing files:
```xml
<fileset dir="${src.dir}" id="src.files">
	<include name="**/*.java"/>
</fileset>
```

Putting a file list inside a property:
```xml
<pathconvert pathsep="," property="javafiles" refid="src.files"/>
```

## concat

Output text to console:
```xml
<concat>
My text.
</concat>
```

Output text to file:
```xml
<concat destfile="myfile">
My text.
</concat>
```

## filterchain

 * [FilterChains and FilterReaders](https://ant.apache.org/manual/Types/filterchain.html).

Filtering text with concat:
```xml
<concat>
My text.
	<filterchain>
		<tokenfilter>
			<replaceregex pattern="My" replace="Our" flags="gi"/>
		</tokenfilter>
	</filterchain>
</concat>
```

Filtering text in a file:
```xml
<copy file="spiid-inchi.txt" tofile="peakforest.tsv">
	<filterchain>
		<linecontainsregexp negate="true">
			<regexp pattern="^(202|203)\s"/>
		</linecontainsregexp>
	</filterchain>
</copy>
```

Replacing tokens in a file:
```xml
<copy file="${tool.xml}" tofile="${dist.dir}/lcmsmatching.xml">
	<filterchain>
		<tokenfilter>
			<replacestring from="@INPUT_FIELDS@" to="${input.fields}"/>
			<replacestring from="@OUTPUT_FIELDS@" to="${output.fields}"/>
		</tokenfilter>
	</filterchain>
</copy>
```
or
```xml
<copy file="${tool.xml}" tofile="${dist.dir}/lcmsmatching.xml">
	<filterchain>
		<replacetokens>
			<token key="TOOL_PREFIX" value="${TOOL.PREFIX}"/>
			<token key="INPUT_FIELDS" value="${input.fields}"/>
		</replacetokens>
	</filterchain>
</copy>
```

## replaceregexp

Replacing text in a file:
```xml
<replaceregexp file="peakforest.tsv" match="^[^\s]+\s" replace="" byline="true"/>
```

## exec

```xml
<exec executable="cmd">
	<arg value="/c"/>
	<arg value="ant.bat"/>
	<arg value="-p"/>
</exec>
```

Stop building process on command failure:
```xml
<exec executable="toto" failonerror="true"/>
```

Set working directory:
```xml
<exec executable="mycmd" dir="mydir"/>
```

Modifying PATH env var when calling command:
```xml
<property environment="env"/>
<target name="db">
	<exec executable="build-db" dir=".">
		<env key="PATH" path="${env.PATH}:${basedir}/db-creation:${basedir}/db-filling"/>
		<arg value="/c"/>
	</exec>
</target>
```

Redirecting error output:
```xml
<exec executable="./analyze-mthspidb" failonerror="true">
	<redirector	error="found-errors.txt" alwayslog="true"/>
	<!-- alwayslog option is necessary in order to keep seeing error output in ant log (ant output). -->
</exec>
```

Filtering output:
```xml
<exec executable="${this.dir}/check-pkg" failonerror="true">
	<redirector>
		<outputfilterchain>
			<tokenfilter>
				<replaceregex pattern="from " replace="from R/"/>
			</tokenfilter>
		</outputfilterchain>
	</redirector>
</exec>
```

## javac

Setting the classpath:
```xml
<javac classpath="somejar:somedir:anotherjar"/>
<javac classpathref="somepathid"/>
```

Force the compiler version or the JDK:
```xml
<javac compiler="javac1.4"/>
<javac target="1.6"/>
```

## java

```xml
<java classname="MyClass" classpathref="my.class.path.ref"/>
```

Enabling assertion in java:
```xml
<java ...>
	<assertions>
		<enable/>
	</assertions>
</java>
```

## junit

```xml
<junit failureProperty="test.failure" dir="${dir.of.this.build.xml.file}" fork="true">
	<classpath>
		<path refid="myclasspath"/>
	</classpath>
	<formatter type="brief" usefile="false"/>
	<batchtest>
		<!-- include all class files except inner classes -->
		<fileset dir="${build.dir}" includes="*.class" excludes="*$*.class"/>
	</batchtest>
</junit>
<fail message="test failed" if="test.failure"/>
```

## jar

```xml
<jar destfile="${ant.project.name}.jar" basedir="${build.dir}">
    <manifest>
        <attribute name="Main-Class" value="${main-class}"/>
    </manifest>
</jar>
```

## zip

```xml
<zip destfile="my_lib.zip" basedir="src" includes="*.R"/>
```

## unzip

```xml
<unzip src="tmp.docx" dest="tmp"/>
```

## tar

```xml
<tar destfile="some/file.tar.gz" compress="gzip">

	<!-- Include files -->
	<tarfileset dir="some.dir">
		<include name="**"/>
		<exclude name="search-mz"/>
	</tarfileset>

	<!-- Include file and set execution rights -->
	<tarfileset dir="${dist.dir}/code" filemode="755">
		<include name="search-mz"/>
	</tarfileset>
</tar>
```

## untar

```xml
<untar src="some.dir/pkg.tar.gz" dest="dest/dir" compression="gzip"/>
```

## get

Download a file:
```xml
<get src="http://some.server.net/path/to/the/file.zip" dest="my.local.file.zip"/>
```

## Environment variables

Getting environment variables:
```xml
<property environment="env"/>
<property name="somevar" value="${env.somevar}"/>
```

## tstamp (time stamp)

Setting the properties DSTAMP and TSTAMP:
```xml
<tstamp/>
```
DSTAMP contains the date in format YYYYMMDD.
TSTAMP contains the time in format HHMMSS.

<property name="dist.name" value="cea-deltadore-${DSTAMP}-${TSTAMP}"/>

## Operating system

Set a property to current OS family name:
```xml
<osfamily property="os"/>
```
Possible values are: "unix", "dos", "mac", "os/2", "os/400", "z/os", "tandem" and "windows".

Testing the current operating system:
```xml
<condition property="isMac">
	<os family="mac" />
</condition>
```

## chmod

Set file access permissions:
```xml
<chmod file="some/file" perm="u+x"/>
```

## for

The for task is part of [ant-contrib](http://ant-contrib.sourceforge.net/tasks/tasks/for.html).

For loop on files:
```xml
<for param="dia.file">
	<path>
		<fileset dir="pictures" includes="*.dia"/>
	</path>
	<sequential>
		<propertyregex property="eps.file" input="@{dia.file}" override="yes" regexp="(^.*)\.dia$" replace="\1.eps"/>
		<diaeps input="@{dia.file}" output="${eps.file}"/>
	</sequential>
</for>
```

## macrodef

Creating a new task:
```xml
<macrodef name="mytask">
	<attribute name="myatt"/>
	<sequential>
		<echo>Do something with attribute @{myatt}</echo>
	</sequential>
</macrodef>
```

Using a created task:
```xml
<mytask myatt="somevalue"/> 
```

## Errors

### 'includeantruntime' not set

ERROR: "warning: 'includeantruntime' was not set, defaulting to build.sysclasspath=last; set to false for repeatable builds".
SOLUTION: set attribute to false in the javac task if you don't want to use system CLASSPATH:
```xml
<target ...>
	<javac ... includeantruntime="false"/>
</target>
```
By default it uses build.sysclasspath value which is set to last by default. This means that system CLASSPATH will be appended to any classpath definition inside the build.xml file.

### JUnit class path

The *classpath* for the `junit` task must include `junit.jar`, unless if it already is in Ant's own classpath. Include the junit in your CLASSPATH. Under MacOS-X the path to the `junit.jar` file is `/usr/share/java/junit.jar`.

### Duplicated project name

ERROR: "warning: Duplicated project name in import. Project build.lib.utils defined first in /Users/pierrick/dev/projects/CLIMB/build-lib/utils.xml and again in /Users/pierrick/dev/projects/CLIMB/java-lib/build-lib/utils.xml".

ANALYZE: The same file can't be included twice, when a project name is defined. If no project name is set, everything will go fine.

SOLUTION: Include the file only once, or remove project name.

### Tools.jar

ERROR: "Unable to locate tools.jar. Expected to find it in C:\Program Files\Java\jre7\lib\tools.jar".

SOLUTION: Set `JAVA_HOME` to point to the JDK (not the JRE). For instance `C:\Program Files\Java\jdk1.7.0_02` on Windows.
