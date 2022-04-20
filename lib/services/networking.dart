import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey='e52ee4e4f64f358d361e52b1a7fe1c87';

class NetworkHelper
{
  final String url;
  NetworkHelper(this.url);
  Future getData() async
  {
    http.Response response= await http.get(Uri.parse(url));

    if (response.statusCode <=250)
    {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);
      return decodedData;
    }
    else{
      print(response.statusCode);
    }
  }

}