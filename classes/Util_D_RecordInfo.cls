/* @name: Util_D_RecordInfo
 * @test: Util_LookupTest
 * @author: Dmytro Lambru
 * @date: 22.05.19
 * @description: Data class for 'Util_LookupController'
 */
public class Util_D_RecordInfo {

	public String recordId {get;set;} 
	public Object record {get;set;}
	public FieldToShowInfo[] fieldToShowInfoList {get;set;}

	public Util_D_RecordInfo() {}

	public Util_D_RecordInfo(JSONParser parser) {

		while (parser.nextToken() != System.JSONToken.END_OBJECT) {

			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();

				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {

					if (text == 'recordId') {
						recordId = parser.getText();
					} else if (text == 'record') {
						record = new Record(parser);
					} else if (text == 'fieldToShowInfoList') {
						consumeObject(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'Util_D_RecordInfo consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}

    public static List<Util_D_RecordInfo> parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);

		return arrayOfUtil_D_RecordInfo(parser);
	}
	
    private static List<Util_D_RecordInfo> arrayOfUtil_D_RecordInfo(System.JSONParser p) {
        List<Util_D_RecordInfo> res = new List<Util_D_RecordInfo>();

        if (p.getCurrentToken() == null) p.nextToken();

        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Util_D_RecordInfo(p));
        }

        return res;
    }

	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;

		do {
			System.JSONToken current = parser.getCurrentToken();

			if (current == System.JSONToken.START_OBJECT || 
				current == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (current == System.JSONToken.END_OBJECT ||
				current == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

	public class FieldToShowInfo {

		public Object fieldLabel {get;set;}
		public String fieldName {get;set;}
		public Object fieldValue {get;set;}
		public Boolean isFieldLabelHidden {get;set;} 
	}

	public class Record {

		public Id Id {get;set;}

		public Record(JSONParser parser) {

			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();

					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {

                        if (text == 'Id') {
							Id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Record consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
}
