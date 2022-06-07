
import 'package:doutores_app/data/models/BlogModel.dart';
import 'package:doutores_app/data/dataproviders//BlogDP.dart';
import 'package:doutores_app/utils/APPConstants.dart';
import 'package:html/parser.dart';

class BlogRepository{

  static List<Blog> last3Posts = [];
  static List<Blog> contabilidadePosts = [];
  static List<Blog> empreendedorismoPosts = [];
  static List<Blog> tecnologiaPosts = [];

  static Future<bool> getLast3Posts() async {

    final response = await BlogSamplePostDataProvider.getLastPosts(defaultBlogPath);

    if (response.statusCode != 200) {
      return false;
    }else{
      last3Posts = fillBlogList(parse(response.body), 3);
      return true;
    }

  }

  static Future<bool> getContabilidadePosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts(contabilidadeBlogPath);
    if (response.statusCode != 200) {
       return false;
    }else{
      contabilidadePosts = fillBlogList(parse(response.body));
       return true;
    }
  }

  static Future<bool> getEmpreendedorismoPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts(empreendedorismoBlogPath);
    if (response.statusCode != 200) {
      return false;
    }else {
      empreendedorismoPosts = fillBlogList(parse(response.body));
       return true;
    }
  }

  static Future<bool> getTecnologiaPosts() async {
    final response = await BlogSamplePostDataProvider.getLastPosts(tecnologiaBlogPath);
    if (response.statusCode != 200) {
      return false;
    }else {
      tecnologiaPosts = fillBlogList(parse(response.body));
       return true;
    }
  }

  static List<Blog> fillBlogList(dynamic response, [int max = 0]){
    var articles = response.getElementsByTagName("article");

    List<Blog> blogList = [];

    if(max == 0) {
      max = articles.length;
    }

    for (var i = 0; i < max; i++) {
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

      blogList.add(
          Blog(
              categoryName: "",
              title: result,
              date: date,
              imagePath: 'https://doutoresdacontabilidade.com.br/' + image,
              details: details,
              url: 'https://doutoresdacontabilidade.com.br/' + url
          )
      );
    }

    return blogList;
  }

}