/* @name: Util_D_SearchConfig
 * @test: Util_LookupTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Data class for 'Util_LookupController'
 */
public class Util_D_SearchConfig {

    public String objectName;
    public Integer numberOfRecords;
    public Boolean isFieldLabelHidden;
    public String[] fieldForSearchList;
    public String[] fieldForQueryList;
    public String[] fieldForOrderList;
    public FieldForFilterCriterion[] fieldForFilterCriterionList;
    public FieldToShow[] fieldToShowList;

    public static Util_D_SearchConfig parse(String jsonSting) {
        return (Util_D_SearchConfig) System.JSON.deserialize(jsonSting, Util_D_SearchConfig.class);
    }

    public class FieldForFilterCriterion {
        
    	public String fieldName;
    	public String condition;
    	public String value;
    	public String typeOfValue;
    }

    public class FieldToShow {

    	public String fieldLabel;
    	public String fieldName;
    	public Boolean isFieldLabelHidden;
    }
}
