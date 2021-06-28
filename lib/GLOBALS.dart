
String LicensePlateRegex(String ve_reg_num){
  String temp = ve_reg_num.replaceAll("\n", "").replaceAll(" ", "");
  RegExp re = RegExp(r'^[A-Za-z]{1,9}[\d]{1,4}[A-Za-z]*$',  multiLine: false);
  if(re.hasMatch(temp)){
    return temp;
  }
}
