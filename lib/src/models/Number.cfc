component displayName="Number" extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="format" type="string";
	property name="number" type="string";

    public function getDisplayText(){
        var value = this.getNumber();
		return value;
	}
}