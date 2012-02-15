module RBTree;

import std.stdio;
import std.string;
import std.conv;

template TRBTree(T)
{
  class RBTree
  {
    enum EColor { RED, BLACK }

    class Node
    {
    public:
      EColor color;
      Node left;
      Node right;
      Node parent;
      T value;
    }

    Node root = null;

    Node grandparent(Node n)
    {
      if (n && n.parent)
	return n.parent.parent;
      return null;
    }

    bool less(T lft, T rgh)
    {
      return lft < rgh;
    }

    void setNodeValue(Node x, T value)
    {
      x.value = value;
    }

    // Right child must exist
    void left_rotate(Node x)
    {
      x.right.parent = x.parent;

      // If x is no root
      if (x.parent)
	{
	  // If situation in right subtree
	  if (x == x.parent.left)
	    x.parent.left = x.right;
	  else
	    x.parent.right = x.right;
	}

      x.parent = x.right;
      x.right = x.right.left;
      x.parent.left = x;

      if (x.right)
	x.right.parent = x;

      if (x == root)
	root = x.parent;
    }

    // Left child must exist
    void right_rotate(Node x)
    {
      x.left.parent = x.parent;

      // If x is not root
      if (x.parent)
	{
	  // If situation in left subtree of x's parent
	  if (x == x.parent.left)
	    x.parent.left = x.left;
	  else
	    x.parent.right = x.left;
	}

      x.parent = x.left;
      x.left = x.left.right;
      x.parent.right = x;

      if (x.left)
	x.left.parent = x;

      if (x == root)
	root = x.parent;
    }

    bool bst_insert(T value, ref Node node)
    {
      Node prev = null;
      node = root;

      while(node)
	{
	  if (less(value, node.value))
	    {
	      prev = node;
	      node = node.left;
	    }
	  else if (less(node.value, value))
	    {
	      prev = node;
	      node = node.right;
	    }
	  else
	    {
	      setNodeValue(node, value);
	      return false;
	    }
	}

      node = new Node;
      node.parent = prev;
      node.left = node.right = null;
      setNodeValue(node, value);

      if(prev)
	less(value, prev.value) ? (prev.left = node) : (prev.right = node);

      if (root is null)
	root = node;

      return true;
    }

    string tree2string(Node node, string tabs)
    {
      if (node is null)
	return '\n' ~ tabs ~ "nil";

      string ntabs = tabs ~ "  ";
      //string value = (node.parent ? text(node.parent.value) : "nil") ~ " : " ~ text(node.value);
      string value = text(node.value);

      if (node.color == EColor.BLACK)
	return "\n" ~ tabs ~ value ~ "\n" ~ tabs ~ "{" ~ tree2string(node.left, ntabs) ~ "," ~ tree2string(node.right, ntabs) ~ "\n" ~ tabs ~ "}";

      value = "<" ~ text(node.value) ~ ">\n";
      return "\n" ~ tabs ~ value ~ tabs ~ "{" ~ tree2string(node.left, ntabs) ~ "," ~ tree2string(node.right, ntabs) ~ "\n" ~ tabs ~ "}";
    }

  public:
    void insert(T value)
    {
      Node x;
      if (bst_insert(value, x) == false)
	return;

      x.color = EColor.RED;

      while(x != root && x.parent.color == EColor.RED)
      	{
      	  Node g = grandparent(x);
      	  if (g is null)
      	    {
	      assert(false);
	      std.stdio.writeln("!g");
      	      // If situation in right subtree of parent
      	      if (x == x.parent.right)
		left_rotate(x.parent);
      	      else
		right_rotate(x.parent);
      	      break;
      	    }

      	  // If situation in left subtree of grandparent
      	  if (x.parent == g.left)
      	    {
      	      Node u = g.right;
      	      // Uncle is red
      	      if (u && u.color == EColor.RED)
      		{
      		  x.parent.color  = u.color = EColor.BLACK;
      		  x = g;
      		  x.color = EColor.RED;
      		}
      	      else
      		{
      		  // If situation in right subtree of parent
      		  if (x == x.parent.right)
      		    {
      		      left_rotate(x.parent);
      		      x = x.left;
      		    }
      		  right_rotate(grandparent(x));
      		  x.parent.color = EColor.BLACK;
		  x.parent.right.color = EColor.RED;

      		  break;
      		}
      	    }
      	  else
      	    {
      	      Node u = g.left;
      	      // Uncle is red
      	      if (u && u.color == EColor.RED)
      		{
      		  x.parent.color = u.color = EColor.BLACK;
      		  x = g;
      		  x.color = EColor.RED;
      		}
      	      else
      		{
      		  // If situation in left subtree of parent
      		  if (x == x.parent.left)
      		    {
      		      right_rotate(x.parent);
      		      x = x.right;
      		    }
      		  left_rotate(grandparent(x));
      		  x.parent.color = EColor.BLACK;
		  x.parent.left.color = EColor.RED;

		  break;
      		}
      	    }
      	}
      root.color = EColor.BLACK;
    }

    void writeln()
    {
      std.stdio.writeln(tree2string(root, ""));
    }
  }
}