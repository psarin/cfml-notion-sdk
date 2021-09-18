component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="start" type="date";
	property name="end" type="date";

    public function getDisplayText(){
        var value = "";
        if (!isNull(this.getStart())){
            value = this.getStart();
        }
        if (!isNull(this.getEnd())){
            value = value & " - " & this.getEnd();
        }
        return value
    }
}