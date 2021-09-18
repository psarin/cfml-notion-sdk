component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="type" type="string";
	property name="string" type="string";

	property name="formula" type="string";

    public function getDisplayText(){
        var value = this.getString();
		return value?:"";
	}    
}