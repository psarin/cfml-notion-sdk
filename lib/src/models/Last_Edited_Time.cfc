component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="last_edited_time" type="date";

    public function getDisplayText(){
        var value = null;
        if (!isNull(this.getLast_Edited_Time())){
            value = datetimeFormat(this.getLast_Edited_Time())
        }
        return value
    }	

}