
class DataBlocHelpers {

  static generateGraphQLQuery(String? endPoint, String? attributeToGet,
      {Map<String, dynamic>? filter}) {
    if(filter != null){
      String filterToString = "";
      filter.forEach((key, value) {
        if(value.runtimeType == String ){
          filterToString += "$key: \"$value\"";
        } else {
          filterToString += "$key: $value";
        }
      });
      return """
        query {
          $endPoint ($filterToString) {
            $attributeToGet
          }
        }
      """;
    }
    return """
      query {
        $endPoint {
          $attributeToGet
        }
      }
    """;
  }

}