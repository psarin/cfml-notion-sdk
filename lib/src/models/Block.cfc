component persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="object" type="string";
	property name="id" type="string" fieldtype="id";

    property name="created_time" type="date" ormtype="timestamp" sqltype="timestamp with time zone";
    property name="last_edited_time" type="date" ormtype="timestamp" sqltype="timestamp with time zone";

    property name="has_children" type="boolean" default="false";
	property name="type" type="string";
    
}