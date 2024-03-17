
typedef ILoop = Function(bool isComplete, int position );

class AbdoLoopManager {


  int size = 0;
  ILoop iLoop;
  int current_position = 0;

  AbdoLoopManager( this.size, this.iLoop) {
    _start();
  }


  void _start( ) {

  next();
  }

  void next()  {

    //check complete
  bool isComplete = checkHaveNext();
  if (isComplete) {
  iLoop( true, current_position);
  return;
  }

  //request next
  int valueBeforeIncrement = current_position;
  current_position++;
  iLoop(false, valueBeforeIncrement);
  }

  bool checkHaveNext() {
  return current_position >= size;
  }

  bool isLastLoop() {
  return current_position == size;
  }



}