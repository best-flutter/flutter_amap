


class TitleOptions{

  final String title;
  final bool showNavBar;


  TitleOptions({
    this.title,
    this.showNavBar : true
});

  Map toMap() {
    return {
      "title":this.title,
      "showNavBar":this.showNavBar
    };
  }


}