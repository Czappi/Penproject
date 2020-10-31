/// Convert year month index to school month index
int convertMonth(int i) {
  switch (i) {
    case 9:
      return 0;
      break;
    case 10:
      return 1;
      break;
    case 11:
      return 2;
      break;
    case 12:
      return 3;
      break;
    case 1:
      return 4;
      break;
    case 2:
      return 5;
      break;
    case 3:
      return 6;
      break;
    case 4:
      return 7;
      break;
    case 5:
      return 8;
      break;
    case 6:
      return 9;
      break;
    default:
      return 0;
  }
}
