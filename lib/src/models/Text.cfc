component extends="Rich_Text" persistent="true" output="false" dynamicInsert="true" dynamicUpdate="true"
{
	/* properties */
	property name="content" type="string";
    property name="link" type="string";

	public function getDisplayText(){
		return variables.content;
	}	
}