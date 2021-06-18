component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="type" type="string";
    property name="text" cfc="Text";
    property name="annotations" cfc="Annotations";
	property name="plain_text" type="string";
	property name="href" type="string";

}