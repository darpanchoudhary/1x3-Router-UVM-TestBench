# 1x3-Router-Design-and-UVM-TestBench
Router 1*3 Design Block Diagram
![IMG_1320](https://github.com/darpanchoudhary/1x3-Router-UVM-TestBench/assets/70278680/0ea28eb0-c8f0-4777-817d-a98c910a14f8)

Router UVM Testbench:
![IMG_1319](https://github.com/darpanchoudhary/1x3-Router-UVM-TestBench/assets/70278680/5312e453-96e8-4234-98ab-3434c96ce631)

#Router packet structure
![IMG_1321](https://github.com/darpanchoudhary/1x3-Router-UVM-TestBench/assets/70278680/b2bca0d5-6011-4308-8a71-9ab3eb446d82)

#Router input protocol
![IMG_1322](https://github.com/darpanchoudhary/1x3-Router-UVM-TestBench/assets/70278680/b7367686-0945-45c4-a6d0-48ad73fa7caa)

#Router output protocol
![IMG_1323](https://github.com/darpanchoudhary/1x3-Router-UVM-TestBench/assets/70278680/75232234-58c9-46af-9ba4-6448b1246bb9)

Features to be verified:
  1.Packet should reach all 3 destinations properly as per the channel address.
  2.All 3 destinations should receive packet of all the possible payload lengths.
  3.When the data is corrupted,error signal should go high.
  4.When data out is not read within 30 cycles of valid out going high,soft reset should occur.
