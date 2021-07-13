
import 'dart:async';

import 'dart:isolate';

import 'package:flutter/foundation.dart';


// void main() {
//   var ret = testCompute();
//   print(ret);
// }
//
// Future<int> testCompute() async {
//   return await compute(syncCalcuateFactorial, 100);
// }
//
// int syncCalcuateFactorial(upperBounds) => upperBounds < 2
//     ? upperBounds
//     : upperBounds * syncCalcuateFactorial(upperBounds - 1);



void coding(SendPort port) {
  print("coding");
  const sum = 1 + 2;
  // 给调用方发送结果
  port.send(sum);
}
void main() {
  print("main start");
  testIsolate();
  print("main end");
  scheduleMicrotask(() {
    print("我是微任务");
  });
  testAwait();
}

testIsolate() async {
  ReceivePort receivePort = ReceivePort(); // 创建管道
  Isolate? isolate = await Isolate.spawn(coding, receivePort.sendPort); // 创建 Isolate，并传递发送管道作为参数
  print("aaaaa");
  // 监听消息
  receivePort.listen((message) {
    print("data: $message");
    receivePort.close();
    isolate?.kill(priority: Isolate.immediate);
    isolate = null;
  });
  print("bbbb");
}


testAwait() async{
  print("1111");
  await Future(() => {print("2222")});
  print("3333");
}