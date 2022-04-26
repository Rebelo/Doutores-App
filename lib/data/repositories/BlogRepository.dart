
import 'package:doutores_app/data/models/BlogSamplePostModel.dart';
import 'package:doutores_app/data/dataproviders//BlogSamplePostDP.dart';

class BlogRepository{

  String preUrl = "https://doutoresdacontabilidade.com.br/";
  static List<BlogSamplePost> last3Posts = [];
  static List<BlogSamplePost> contabilidadePosts = [];
  static List<BlogSamplePost> empreendedorismoPosts = [];
  static List<BlogSamplePost> tecnologiaPosts = [];

  static Future<void> getLast3Posts() async {

    List<BlogSamplePost> blogLastPosts = [];

    final response = await BlogSamplePostDataProvider.getLastPosts("blog.html");
    var articles = response.getElementsByTagName("article");

    for( var i = 0 ; (i < articles.length) && (i < 3); i++ ) {
      var element = articles[i];

      var title = element.getElementsByTagName("a")[0].attributes['title']?.replaceAll("<br/>", "\n")?.replaceAll("<br />", "\n");
      var date = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("span")[0].text;
      var image = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("img")[0].attributes['src'];
      var details = element.getElementsByTagName("a")[0].children[2].text;
      var url = element.getElementsByTagName("a")[0].attributes['href'];

      blogLastPosts.add(
          BlogSamplePost(
              categoryName: "",
              title: title,
              date: date,
              imagePath: image,
              details: details,
              url: url
          )
      );
    }

    last3Posts = blogLastPosts;
  }


  static Future<void> getContabilidadePosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("contabilidade.html");
    test(response, contabilidadePosts);
  }

  static Future<void> getEmpreendedorismoPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("empreendedorismo.html");
    test(response, empreendedorismoPosts);
  }

  static Future<void> getTecnologiaPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts("tecnologia-e-o-futuro-dos-negocios.html");
    test(response, tecnologiaPosts);
  }


  static void test(dynamic response, List<BlogSamplePost> object){
    var articles = response.getElementsByTagName("article");

    List<BlogSamplePost> posts = [];

    articles.forEach((element) {
      var title = element.getElementsByTagName("a")[0].attributes['title'];
      var date = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("span")[0].text;
      var image = element.getElementsByTagName("a")[0].getElementsByTagName("figure")[0].getElementsByTagName("img")[0].attributes['src'];
      var details = element.getElementsByTagName("a")[0].children[2].text;
      var url = element.getElementsByTagName("a")[0].attributes['href'];

      posts.add(
          BlogSamplePost(
              categoryName: "",
              title: title,
              date: date,
              imagePath: image,
              details: details,
              url: url
          )
      );
    });

    object = posts;
  }

}