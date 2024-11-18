
class DataBlocHelpers {

  static generateGraphQLQuery(String? endPoint, String? attributeToGet,
      {Map<String, dynamic>? filter, bool useMetadata = false}) {
    String metadata = "";
    String filterToString = "";
    if(useMetadata){
      if(filter != null){
        if(!filter.containsKey("page")){
          filter.addAll({"page" : 1});
        } else if( !filter.containsKey("count")){
          filter.addAll({"count" : 10});
        }
      } else {
        filter = {
          "page" : 1,
          "count" : 10
        };
      }
    }
    if(filter != null){
      filter.forEach((key, value) {
        if(value.runtimeType == String ){
          filterToString += "$key: \"$value\"";
        } else {
          filterToString += "$key: $value";
        }
      });
      filterToString = "($filterToString)";
    }
    if(!useMetadata){
      return """
        query {
          $endPoint $filterToString $metadata{
            $attributeToGet
          }
        }
      """;
    } else {
      metadata = "metadata{total,per_page,current_page,last_page}";
      return """query{$endPoint $filterToString{$metadata,data{$attributeToGet}}}""";
    }
    // {programmespaginated(page:1,count:7,is_front:true){metadata{total,per_page,current_page,last_page},data{id}}}
  }

}
