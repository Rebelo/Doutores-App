
import 'package:doutores_app/data/models/BlogSamplePostModel.dart';
import 'package:doutores_app/data/dataproviders//BlogSamplePostDP.dart';


class BlogRepository{

  static List<BlogSamplePost> last3Posts = [];
  static List<BlogSamplePost> contabilidadePosts = [];
  static List<BlogSamplePost> empreendedorismoPosts = [];
  static List<BlogSamplePost> tecnologiaPosts = [];

  static Future<void> getLast3Posts() async {

    final response = await BlogSamplePostDataProvider.getLastPosts("blog.html");
    if (response is String) {

    }else{
      last3Posts = fillObjects(response, 3);
    }
  }


  static Future<void> getContabilidadePosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("contabilidade.html");
    if (response is String) {

    }else{
      contabilidadePosts = fillObjects(response);
    }

  }

  static Future<void> getEmpreendedorismoPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("empreendedorismo.html");
    if (response is String) {

    }else {
      empreendedorismoPosts = fillObjects(response);
    }
  }

  static Future<void> getTecnologiaPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("tecnologia-e-o-futuro-dos-negocios.html");
    if (response is String) {

    }else {
      tecnologiaPosts = fillObjects(response);
    }
  }

  static List<BlogSamplePost> fillObjects(dynamic response, [int max = 0]){
    var articles = response.getElementsByTagName("article");

    List<BlogSamplePost> posts = [];

    if(max == 0) {
      max = articles.length;
    }

    for (var i = 0; (i < max) && (i < 3); i++) {
      var element = articles[i];
      var title = element.getElementsByTagName("a")[0].attributes['title'];
      var date = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("span")[0].text;
      var image = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("img")[0].attributes['src'];
      var details = element.getElementsByTagName("a")[0].children[2].text;
      var url = element.getElementsByTagName("a")[0].attributes['href'];

      var result = title.replaceAll("<br/> ","\n");
      result = result.replaceAll("<br /> ","\n");
      result = result.replaceAll("<br> ","\n");
      result = result.replaceAll("<br > ","\n");
      result = title.replaceAll("<br/>","\n");
      result = result.replaceAll("<br />","\n");
      result = result.replaceAll("<br>","\n");
      result = result.replaceAll("<br >","\n");

      posts.add(
          BlogSamplePost(
              categoryName: "",
              title: result,
              date: date,
              imagePath: 'https://doutoresdacontabilidade.com.br/' + image,
              details: details,
              url: 'https://doutoresdacontabilidade.com.br/' + url
          )
      );
    }

    return posts;
  }

}