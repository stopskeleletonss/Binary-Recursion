String[] readvalues, splitvalues; //string arrays for reading the values from the csv file and for splitting the joined data from the csv file
String combinevalues; //string that combines the data from the csv file
int[] numvalues; //int array for switching the data from the csv file to numerical
int wantednum; //variable for the value currently being searched for in the numvalues array
float currenttime; //float variable for the current time passed in milliseconds since the program began
boolean timerstop; //boolean for whether the timer has stopped or not

void setup() {
  size(200,200);
  valuesetup();
  sortvalues();
}

void draw() {
  background(0);
  timer();
  binsearch(numvalues, 0, numvalues.length, wantednum);
}

void valuesetup() { //function to prepare the values from the csv file to be sorted
  readvalues = loadStrings("numbers.txt"); //loads the data from the file into the readvalues array
  combinevalues = join(readvalues, ","); //combines the values held in the readvalues array into one line
  splitvalues = split(combinevalues, ","); //splits the values held in the combinevalues array back into their own separate lines
  numvalues = int(splitvalues); //converts the strings held in the splitevalues array to numerical values
  wantednum = 822; //the value being searched for in the data is currently 33, but can be changed to any number
}


void sortvalues() { //function that sorts the values from least to greatest by comparingthem to the adjacent value to the right
  for (int index = 0; index < splitvalues.length; index++) { //index variable has an initial value of 0, must be less than the length of splitvalues array, and increases by increments of 1
    for (int index1 = 0; index1 < splitvalues.length-index-1; index1++) { //index1 variable has an initial value of 0, must be less than the length of splitvalues array minus the value of index and an additional -1, and increases by increments of 1
      if (numvalues[index1] > numvalues[index1+1]) { //if a value in the array is larger than the next value in the array
        int temp = (numvalues[index1]); //the value of the larger number is stored in the temp variable
        numvalues[index1] = numvalues[index1+1]; //the smaller number moves to the position in the array that contained the larger number
        numvalues[index1+1] = (temp); //the larger number moves to the position in the array that contained the smaller number
      }
    }
  }
}

void timer() {
 fill(255);
 textAlign(CENTER);
 textSize(50);
 text(currenttime/1000, width/2, height/2);
 if (timerstop==false) { //if the timer hasn't been stopped
   currenttime=millis(); //currenttime is equal to the amount of milliseconds since the program started
 }
}


int binsearch(int[] numvalues, int low, int high, int target) { //function to search the data in the array by dividing the interval being searched in half over and over until it finds the desired value
    if (low<high) { //if the lowest number is less than the highest number
    int mid = low + (high-low) / 2; //the middle number is equal to the lowest number plus the highest number minus the lowest number divided by two

    if (target<numvalues[mid]) //if the target number is less than the middle number in the array
      return binsearch(numvalues, low, mid, target); //the end of the search range is set to the middle number
    else if (target>numvalues[mid]) //if the target number is greater than the middle number in the array
      return binsearch(numvalues, mid+1, high, target); //the start of the search range is set to one to the right of the middle number
    else {
      if (timerstop==false) { //if the timer has not ended
        println(target + " is in index " + mid + " of the array.");
        timerstop=true; //the timer has ended
        return mid; //returns the mid value
      }
    }
  }
  return -(low=1);
}
