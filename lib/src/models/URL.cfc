component extends="BaseObject" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */

	property name="url" type="string";

    public function getDisplayText(){
        var value = this.getUrl();
		return !isNull(value)?"<a href='#value#'>#value#</a>":"";
	}    
}