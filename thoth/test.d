import std.stdio;
import std.conv;

import RBTree;

void main()
{
  TRBTree!(int).RBTree tree = new TRBTree!(int).RBTree;

  tree.insert(10);
  tree.writeln();

  tree.insert(9);
  tree.writeln();

  tree.insert(8);
  tree.writeln();

  tree.insert(7);
  tree.writeln();

  tree.insert(6);
  tree.writeln();

  tree.insert(5);
  tree.writeln();

  tree.insert(4);
  tree.writeln();

  tree.insert(3);
  tree.writeln();

  tree.insert(2);
  tree.writeln();

  tree.insert(1);
  tree.writeln();

  tree.insert(0);
  tree.writeln();

  tree.insert(10);
  tree.writeln();

  tree.insert(7);
  tree.writeln();

  tree.insert(20);
  tree.writeln();

  tree.insert(20);
  tree.writeln();

  tree.insert(7);
  tree.writeln();

  tree.insert(21);
  tree.writeln();

  tree.insert(22);
  tree.writeln();

  tree.insert(1);
  tree.writeln();

  tree.insert(8);
  tree.writeln();

  tree.insert(3);
  tree.writeln();

  tree.insert(9);
  tree.writeln();
}