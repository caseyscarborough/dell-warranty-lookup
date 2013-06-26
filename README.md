Dell Warranty Lookup
====================

This is a simple Ruby script used to pull warranty data about a Dell machine based on its service tag.

Usage
-----

The script can be run by running the following command:
```
$ ruby dell_warranty.rb <service_tag>
````

Output:
```
$ ruby dell_warranty.rb 9tp9tk1

Model: Latitude E6500
Service Tag: 9TP9TK1

Start Date: 08-21-2009
End Date: 08-22-2013
Days Left: 58
```