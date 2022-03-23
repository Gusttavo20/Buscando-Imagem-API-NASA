//Convete as datas em string. Para que as apis consiga ler.
class DateInputConverter {
  String format(DateTime date) {
    var dateSplitted = date.toString().split(' ');
    return dateSplitted.first;
  }
}
