component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="created_time" type="date";


    public function getDisplayText(){
        var value = null;
        if (!isNull(this.getCreated_Time())){
            value = datetimeFormat(this.getCreated_Time())
        }
        return value
    }	
	
}