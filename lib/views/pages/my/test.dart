

import 'dart:async';

import 'dart:isolate';

void main() {

//   var counterStream = Stream<int>.periodic(Duration(seconds: 1), (x) => x).take(15);
//
//   var onData = (int x) => {
//     print('ondata ${x}')
//   };
//   // ignore: argument_type_not_assignable_to_error_handler
//   var e = counterStream.listen(onData, onDone: ()=>{print('onDone')});
//
//   Future.delayed(Duration(seconds: 5), ()=>{e.cancel()});
//
//   //counterStream.forEach(print);
//
//   //var doubleCounterStream = counterStream.map((int x) => x * 2);
//   //doubleCounterStream.forEach(print);
// //   counterStream.where((int x) => x.isEven)
// //     .expand((var x) => [x, x])
// //     .take(5)
// //     .forEach(print);

  // listenAfterDelay();
  // listenWithPause();

  // new Future(() => 21)
  //     .then((v) => v*2)
  //     .then((v) => print(v));

  test6();
}

void test6() {
  createTask();//创建线程
  scheduleMicrotask(() {//第一个微任务
    print('H1');
    scheduleMicrotask(() {//第一个紧急任务
      print('H1-1');
    });
    Timer.run(() {//第一个非紧急任务
      print('L1-2');
    });
  });
  scheduleMicrotask(() {// 第二个高优先级任务
    print('H2');
    scheduleMicrotask(() {//第二个紧急任务
      print('H2-1');
    });
    Timer.run(() {//第二个非紧急任务
      print('L2-2');
    });
  });
  Timer.run(() {// 第一个低优先级任务
    print('L3');
    scheduleMicrotask(() {//第三个紧急任务
      print('H3-1');
    });
    Timer.run(() {//第三个非紧急任务
      print('L3-2');
    });
  });

  Timer.run(() {// 第二个低优先级任务
    print('L4');
    scheduleMicrotask(() {//第四个紧急任务
      print('H4-1');
    });
    Timer.run(() {//第四个非紧急任务
      print('L4-2');
    });
  });
}

/// 新线程执行新的任务 并监听
late Isolate isolate;
void createTask() async {
  ReceivePort receivePort = ReceivePort();
  isolate = await Isolate.spawn(sendPort, receivePort.sendPort);
  receivePort.listen((data) {
    print(data);
  });
}
/// 新线程执行任务
void sendPort(SendPort sendPort) {

  scheduleMicrotask(() {
    print('IH5-1');
  });
  Timer.run(() {
    print('IL5-2');
  });
  sendPort.send('第三方执行任务结束');
}

// String name='fgyong';
// void test5()async{
//   ReceivePort rece = ReceivePort();
//   Isolate isolate = await Isolate.spawn(sendPort, rece.sendPort);
//   rece.listen((data){
//     print('收到了 ${data} ,name:$name');
//   });
// }
// void sendPort(SendPort sendPort){
//   sendPort.send('发送消息');
// }


// NOTE: This implementation is FLAWED!
// It starts before it has subscribers, and it doesn't implement pause.
Stream<int> timedCounter(Duration interval, [int? maxCount]) {
  var controller = StreamController<int>();
  int counter = 0;
  void tick(Timer timer) {
    counter++;
    controller.add(counter); // 请求 Stream 将计数器值作为事件发送。
    if (maxCount != null && counter >= maxCount) {
      timer.cancel();
      controller.close(); // 请求 Stream 关闭并告知监听器。
    }
  }

  controller.onListen = () => {
    Timer.periodic(interval, tick)
  };
  return controller.stream;
}

void listenAfterDelay() async {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  await Future.delayed(const Duration(seconds: 5));

  // 5 秒后添加一个监听器。
  await for (int n in counterStream) {
    print(n); // 每秒打印输出一个整数，共打印 15 次。
  }
}

Stream<int> timedCounter2(Duration interval, [int? maxCount]) {
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;

  void tick(_) {
    counter++;
    controller.add(counter); // 请求stream将计数器值作为事件发送。
    if (counter == maxCount) {
      timer?.cancel();
      controller.close(); // Ask stream to shut down and tell listeners.
    }
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
  );

  return controller.stream;
}

void listenWithPause() {
  var counterStream = timedCounter2(const Duration(seconds: 1), 15);
  late StreamSubscription<int> subscription;

  subscription = counterStream.listen((int counter) {
    print(counter); // 每秒打印输出一个整数。
    if (counter == 5) {
      // 打印输出 5 次后暂停 5 秒然后恢复。
      subscription.pause(Future.delayed(const Duration(seconds: 5)));
    }
  });
}