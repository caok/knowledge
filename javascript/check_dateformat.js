function checkdateformat(date) {
  var dateformat = /^(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])\/\d{4}$/;
  if(date.match(dateformat)){
    var splitdate= date.split('/');

    var mm = parseInt(splitdate[0]);
    var dd = parseInt(splitdate[1]);
    var yy = parseInt(splitdate[2]);
    var ListofDays = [31,28,31,30,31,30,31,31,30,31,30,31];
    if (mm>12) {
      return false;
    }
    if (mm==1 || mm>2) {
      if (dd>ListofDays[mm-1]) {
        return false;
      }
    }
    if (mm==2) {
      var lyear = false;
      if ( (!(yy % 4) && yy % 100) || !(yy % 400)) {
        lyear = true;
      }
      if ((lyear==false) && (dd>=29)) {
        return false;
      }
      if ((lyear==true) && (dd>29)) {
        return false;
      }
    }
    return true;
  } else {
    return false;
  }
};
