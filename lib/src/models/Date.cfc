component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="start" type="date";
	property name="end" type="date";

    private function formatDateTime(dt){
        return dateTimeFormat(dt, 'YYYY-MM-dd HH:nn:ss');
    }

    public function getDisplayText(){
        var value = "";
        if (!isNull(this.getStart())){
            value = formatDateTime(this.getStart());
        }
        if (!isNull(this.getEnd())){
            value = value & " - " & formatDateTime(this.getEnd());
        }
        return value
    }
}