component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="database_id" type="string";
	property name="synced_property_name" type="string";
	property name="synced_property_id" type="string";

    public function getDisplayText(){
        var value = this.getID();
		return value;
	}    
}