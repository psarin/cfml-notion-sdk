component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="id" type="string" fieldtype="id";

	property name="name" type="string" default="blah";
	property name="color" type="string";

	property name="options" type="array";
}