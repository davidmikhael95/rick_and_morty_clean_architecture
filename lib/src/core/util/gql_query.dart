class GqlQuery {
  static String charactersQuery = '''
  query (\$page: Int!){
    characters(page: \$page){
      results{
        id
        name
        type
        gender
        status
        species
        image
        episode {
          id
          name
        }
      }
    }
  }
  ''';


   static String characterDetailsQuery = '''
  query (\$id: ID!){
    character(id: \$id){
        id
        name
        type
        gender
        status
        species
        image
        episode {
          id
          name
        }
    }
  }
  ''';
}