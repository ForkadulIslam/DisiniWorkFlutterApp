import 'dart:convert';

import 'package:disiniwork/Models/ProjectDataModel.dart';
import 'package:disiniwork/components/ProjectItemCard.dart';
import 'package:disiniwork/pages/navigationbar_content/ProjectDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/CateogoryModel.dart';
import '../../components/BuildInputDecoration.dart';
import '../../constants.dart';
import 'dart:async';

class BrowseProjectContent extends StatefulWidget {
  const BrowseProjectContent({super.key});

  @override
  State<BrowseProjectContent> createState() => _BrowseProjectContentState();
}

class _BrowseProjectContentState extends State<BrowseProjectContent> {

  final Uri baseUri = Uri.parse('$apiBaseUrl/getjobs');
  int pageNo = 1, nextPage=0, prevPage=0;
  Uri? finalUri;
  List<ProjectDataModel> projects = [];
  String? categorySlug;
  String? selectedPriceFilter;
  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];
  final TextEditingController skillInputController = TextEditingController();
  // Create a debounce instance with a delay of 500 milliseconds
  Timer? _debounce;
  bool loading  = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProject();
    getCategory();
  }
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  getCategory() async{
    try{
      final Uri url = Uri.parse('$apiBaseUrl/getcategories');
      var response = await http.get(url);
      final responseData = json.decode(response.body);
      print(responseData);
      if(response.statusCode == 200){
        var _category = (responseData as List).map((item){
          return CategoryModel(item['id'], item['name'], item['slug']);
        }).toList();
        var _selectedCategory = _category.where((element) => element.slug == categorySlug);
        if(_selectedCategory.length > 0){
          setState(() {
            selectedCategory = _selectedCategory.first;
          });
        }
        setState(() {
          categories = _category;
        });
      }
    }catch(error){
      print('Error from category: ${error}');
    }
  }
  getProject() async{
    setState(() {
      loading = true;
    });
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token').toString();
      // Prepare the query parameters map
      Map<String, String> queryParams = {
        'page': pageNo.toString(), // Default page
        if (skillInputController.text.isNotEmpty) 'skill': skillInputController.text,
        if(selectedPriceFilter != null) 'bylowandhigh': selectedPriceFilter.toString(), // Use the selected price filter or default to 'low'
        if (selectedCategory != null) 'catid': selectedCategory!.slug,
      };
      Uri finalUri = baseUri.replace(queryParameters: queryParams);
      var response = await http.get(
        finalUri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        var _projects = (jsonResponse['data'] as List).map((item){
          List<dynamic> _skills = item['skills'];
          String skillString = _skills.map((skill) => skill['name']).join(', ');
          return ProjectDataModel(
            title: item['title'],
            description: item['description'],
            projectType: 'Hourly',
            noOfProposal: item['bids'].toString(),
            price: item['budget'].toString(),
            slug: item['slug'].toString(),
            skills: skillString,
            publishedAt: item['created_at'],
          );
        }).toList();
        // Parse the JSON response


        // Extract the next page number
        int? _nextPage = extractNextPage(jsonResponse['links']['next']);
        setState(() {
          loading = false;
          projects = _projects;
          nextPage = _nextPage!;
        });
      }
    }catch(error){
      print('Error: $error');
    }
  }
  int? extractNextPage(String? nextLink) {
    if (nextLink != null) {
      Uri uri = Uri.parse(nextLink);
      return int.tryParse(uri.queryParameters['page'] ?? '');
    }
    return 0;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Align(
            child: Text(
              textAlign:TextAlign.center,
              'Browse Project',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: skillInputController,
              textAlignVertical: TextAlignVertical.center, // Center-align the text vertically
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                filled: true, // Set to true to enable background color
                fillColor: const Color(0xfff0f1f5),
                prefixIcon: const Icon(Icons.search), // Search icon on the left
                hintText: 'Search by skill...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xfff0f1f5)), // Border color when focused
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  setState(() {

                  });
                  getProject();
                });
              },

            ),
          ),
          SizedBox(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight, // Align to the right
              child: InkWell(
                onTap: () {
                  _showMoreFilter();
                },
                child: Text(
                  'More Filter',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff666666), // Set text color to blue
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Add underline
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          if(loading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff031a38)), // Change this to your desired color
                strokeWidth: 2,
              ),
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async{
                    // SharedPreferences pref = await SharedPreferences.getInstance();
                    // String token = pref.getString('token').toString();
                    // String slug = projects[index].slug;
                    // String url = 'https://disiniwork.com/jobs/$slug?appkey=${token}';
                    // //print(url);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetails(url: projects[index].slug)));
                  },
                  child: ProjectItemCard(project: projects[index]),
                );
              },
            ),
          ),
          // Pagination button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(pageNo > 1)
                  SizedBox(
                    height: 25,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          pageNo = nextPage -1;
                        });
                        getProject();
                      },
                      icon: Icon(Icons.arrow_back, size: 13,),
                      label: Text(
                        'Previous',
                        style: TextStyle(color: Colors.white,fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffe37070), // Change to your desired color
                      ),
                    ),
                  ),
                SizedBox(width: 16),
                if(nextPage > 1)
                  SizedBox(
                    height: 25,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          pageNo = nextPage;
                        });
                        getProject();
                      },
                      icon: Icon(Icons.arrow_forward, size: 13,),
                      label: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffe37070), // Change to your desired color
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 1,)
        ],
      ),
    );
  }


  void _showMoreFilter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    validator: (CategoryModel? value) {
                      if (value == null) {
                        return 'Category is required';
                      }
                      return null; // Return null if the value is valid
                    },
                    decoration: buildInputDecoration('Category', Icons.category_outlined),
                    value: selectedCategory,
                    onChanged: (CategoryModel? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        if (selectedCategory != null) {
                          // Here, you can send selectedCategory.slug to the server
                          // print("Selected Slug: ${selectedCategory!.slug}");
                        }
                      });
                    },
                    items: categories.map((CategoryModel category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name)
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                // Price Dropdown
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedPriceFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPriceFilter = newValue;
                        // Here, you can send selectedPriceFilter to the server
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'low',
                        child: Text('Low to High'),
                      ),
                      DropdownMenuItem(
                        value: 'high',
                        child: Text('High to Low'),
                      ),
                    ],
                    decoration: buildInputDecoration('Price', Icons.attach_money),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement your search logic here using input1Controller.text and input2Controller.text
                getProject();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Search'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );

      },
    );
  }

}
