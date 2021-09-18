component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
    property name="avatar_url" type="string";
	property name="person" type="struct" field-type="one-to-one" cfc="Person";

}