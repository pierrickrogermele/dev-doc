GALAXY
======

  * [Galaxy](https://galaxyproject.org) official site.
  * [Un petit tutoriel](http://cati-bbric.toulouse.inra.fr/doku.php/galaxy).
  * [IFB Galaxy tutorial](http://www.france-bioinformatique.fr/sites/default/files/20150522v0.99.1-galaxyadvancedfeaturesfortoolintegration_0.pdf).

  * [John Chilton's page](https://wiki.galaxyproject.org/JohnChilton) on the Galaxy Project Wiki.
  * [John Chilton's GitHub page](https://github.com/jmchilton?tab=repositories).
  * Galaxy offers an API, accessible through URL requests. Two sort of APIs are available : native API and API through BioBlend.

  * A Galaxy instance can be connected to a local cluster in order to execute HPC jobs.

 * After quickly reviewing the GitHub page of [John Chilton](https://github.com/jmchilton?tab=repositories) found by Steffen, putting aside repositories not recently updated (last year or before):
   - [Docker build](https://github.com/jmchilton/docker-build): is forked from [Galaxy Project's starforge](https://github.com/galaxyproject/starforge). It is a docker for building Galaxy Tool Shed dependencies. I did not test it. Could be interesting for the W4M VM, but not for Phenomenal microservices where tools will be embedded in Docker containers.
   - [Galaxy Docker Image](https://github.com/jmchilton/docker-galaxy-stable): is forked from [Björn Grüning's repository](https://github.com/bgruening/docker-galaxy-stable). Works, but can't run port forwarding on MacOS-X => *try it under Linux*.
   - [Ansible Galaxy Tool Shed](https://github.com/jmchilton/ansible-galaxy-toolshed): An Ansible role for installing and managing Galaxy Tool Shed servers.
   - [Ansible Galaxy](https://github.com/galaxyproject/ansible-galaxy/): An Ansible role for installing and managing Galaxy servers.
   - [Pulsar](https://github.com/jmchilton/pulsar): Python server application that allows a Galaxy server to run jobs on remote systems (including Windows). See John Chilton's page at Galaxy Project site: <https://wiki.galaxyproject.org/JohnChilton>.

 * [Ansible Galaxy tools role](https://github.com/galaxyproject/ansible-galaxy-tools). An Ansible role for automated installation of tools from a Tool Shed into Galaxy, with a example of use at <https://github.com/afgane/galaxy-tools-playbook>, a ready-to-use Ansible playbook for the Galaxy Tools role.
 * [ArtBio projet Galaxy tools](https://github.com/mvdbeek/tools-artbio). Use Jenkins for testing.
 * [Galaxy Tool testing in Jenkins](https://github.com/galaxy-iuc/jenkins-testing).

Related projects:
 * [Arvados](https://arvados.org/).

## Installing

 * A [page](http://vallandingham.me/galaxy_install.html) about how to install Galaxy with a service script example.
 * A [playbook](https://github.com/afgane/galaxy-tools-playbook) for automated installation of Galaxy tools using [Ansible](http://www.ansible.com).

```bash
git clone https://github.com/galaxyproject/galaxy
cd galaxy
git checkout -b master origin/master    # in order to get the stable version
```

 * [Installing a tool](https://wiki.galaxyproject.org/Admin/Tools/AddToolTutorial).

## Running

```bash
sh run.sh
```

Note:
In the W4M version, the script running the Galaxy service is `/etc/rc.d/init.d/galaxy`. It calls the script `/galaxy/dist/galaxy-pfem/run.sh`.
To get the version of the installed instance of Galaxy, run:
```
grep -i version /galaxy/dist/galaxy-pfem/PATCHNOTES.txt
```

## Job runners/schedulers

 * [Running Galaxy Tools on a Cluster](https://wiki.galaxyproject.org/Admin/Config/Performance/Cluster).
 * [Pulsar official site](https://pulsar.readthedocs.org/en/latest/index.html). Pulsar is based on the deprecated [LWR](https://lwr.readthedocs.org/en/latest/).
 * [Pulsar sources](https://github.com/jmchilton/pulsar).
 * [CloudMan](https://wiki.galaxyproject.org/CloudMan).

Galaxy should work with any DRM (Distributed Resources Managers) that implements a [DRMAA](http://www.drmaa.org/) interface.

## Planemo

 * [Planemo](https://github.com/galaxyproject/planemo).
 * [Planemo documentation](http://planemo.readthedocs.org/en/latest/index.html).
 * [IFB Planemo course at Galaxy Day 19/11/2015](http://www.france-bioinformatique.fr/sites/default/files/gd2015-planemo-1.0_0.pdf).

macOS Homebrew installation:
```bash 
brew tap galaxyproject/tap
brew install planemo
```

Running planemo on an XML tool file:
```bash
planemo lint mytool.xml
```

### Using Conda

 * [Using Conda with Planemo](http://planemo.readthedocs.io/en/latest/readme.html#conda).

```bash
planemo conda_init
planemo conda_install .
planemo test --galaxy_branch release_16.01 --conda_dependency_resolution .
planemo serve --galaxy_branch release_16.01 --conda_dependency_resolution .
```

Requirements must be set in tool XML file:
```xml
<requirements>
	<requirement type="package" version="3.2.2">R</requirement>
	<requirement type="package">r-batch</requirement>
	<requirement type="package">r-pmcmr</requirement>
</requirements>
```
The packages are looked for inside [bioconda](https://bioconda.github.io/index.html) GitHub repository.

Be careful to use the variable `$__tool_directory__` to call the tool:
```xml
<command><![CDATA[
	$__tool_directory__/univariate_wrapper.R
	...
]]></command>
```

## Workflows

You can export a workflow from Galaxy, it will have the `.ga` extension. You can the import it, at the condition that all required tools are already installed.

You can also publish a workflow on a Toolshed (**TODO: how ?**), and when installing it, Galaxy should install all required tools (**TODO: to check.**).

## XML tool file

  * [Tool XML file syntax](https://wiki.galaxyproject.org/Admin/Tools/ToolConfigSyntax).

### Selection list from an external file

Using an external file for a selection list:
```xml
<param name="columns" label="Chromatographic columns" type="select" display="checkboxes" multiple="true" optional="true" help="Set here the list of chromatographic columns against which the retention time matching will be run.">
	<options from_file="lcmsmatching-columns.tsv">
		<column name="name" index="1"/>
		<column name="value" index="0"/>
	</options>
</param>
```
The file `lcmsmatching-columns.tsv` looks like this:
```
zicphilic-150*5*2.1-shimadzuexactive	zicphilic-150*5*2.1-shimadzuexactive
uplc-c8	uplc-c8
hsf5	hsf5
hsf5-30min-exactive	hsf5-30min-exactive
hplc-c18-qtof	hplc-c18-qtof
uplc-c18	uplc-c18
```

However this solution does not allow to modify dynamically the external file. If it is changed, Galaxy has to be restarted in order to take the changes into account and refresh the tool's page.

Another solution is to you a database file, however I don't think dynamical update of the file is possible either (TODO to check):
```xml
<param name="database" type="select" label="Nucleotide BLAST database">
<options from_data_table="blastdb" />
</param>
```
The column information is then instead defined via `tool-data/tool_data_table_conf.xml.sample`:
```xml
<table name="blastdb" comment_char="#">
<columns>value, name, path</columns>
<file path="tool-data/blastdb.loc" />
</table>
```

### Conditional

```xml
<conditional name="rt">

	<param name="usert" type="select" label="Use retention times">
		<option value="no">No</option>
		<option value="yes">Yes</option>
	</param>

	<when value="no">
	</when>
	<when value="yes">
		<param name="rttolx" label="RTX: retention time tolerance, parameter x (in seconds)" type="float" help="" value="5"/>
		<param name="rttoly" label="RTY: retention time tolerance, parameter y" type="float" help="" value="0.8"/>
		<param name="rttolz" label="RTZ: retention time tolerance used when 'precursor match' is enabled (in seconds)" type="float" help="" value="5"/>
	</when>
</conditional>
```

The inside the command:
```xml
	<command interpreter="Rscript">
		myscript ...

		#if $rt.usert == "no"
			--myopt $rt.rttolx
		#end if
	</command>
```

### Cheetah

Cheetah is used to preprocess the command.

#### if else end

See <http://www.cheetahtemplate.org/docs/users_guide_html_multipage/flowControl.if.html>.

```
#if $size >= 1500
It's big
#else if $size < 1500 and $size > 0 
It's small
#else
It's not there
#end if
```

### Command

#### Variables

The '$var' variables come from parameter fields.
The '${var.metadata.MyField}' variables come from object metadata.

Use `<![CDATA[]]` construct if you need to use special characters (& < >) in your command:
```xml
<command interpreter="Rscript"><![CDATA[
	search-mz -i "$mzrtinput"
]]></command>
```

### Section

It's possible to group parameters inside a section:
```xml
<section name="db" title="Database" expanded="true">
	<!-- Database file -->
	<param name="file" label="Database file" type="data" format="tabular" help=""/>
</section>
```

However this feature does not seem available in Galaxy 2014.06.12.

### Errors

#### EOF when reading a line

`Error executing tool: EOF when reading a line`

Happens when the names of output files are wrong. For instance if a wrong (i.e.: non existing) variable is used to form the name of an output file. In the following example, the error occurs if the variable `input` is not defined:
```xml
	<outputs>
		<data name="mainoutput" label="${tool.name}_${input.name}" format="tabular"/>
	</outputs>
```
