module BinaryTree;

template TBinaryTree(T)
{
  class BinaryTree
  {
  public:
    
    class Node
    {
    public:
      Node parent;
      Node left;
      Node right;
      T    value;
    }

  private:
    Node root = null;

  private:
    Node innerFind(Node x, T value)
    {
      while (x)
	{
	  if (less(x.value, value))
	    x = x.left;
	  else if (less(value, x.value))
	    x = x.right;
	  else
	    return x;
	}
      return null;
    }

    Node innerMin(Node x)
    {
      while (x.left)
	x = x.left;
      return x;
    }

    Node innerMax(Node x)
    {
      while (x.right)
	x = x.right;
      return x;
    }
    
    // The smallest key than greater x
    Node successor(Node x)
    {
      if (x.right)
	return innerMin(x.right);

      Node p = x.parent;

      while (p && x == p.right)
	{
	  x = p;
	  p = p.parent;
	}

      return p;
    }

    // The great key than less x
    Node predessor(Node x)
    {
      if (x.left)
	return innerMax(x.left);

      Node p = x.parent;

      while (p && x == p.left)
	{
	  x = p;
	  p = p.parent;
	}

      return p;
    }

    void transplant(ref Node r, Node u, Node v)
    {
      Node u_parent = u.parent;

      if (u_parent is null)
	r = v;
      else if (u == u_parent.left)
	u_parent.left = v;
      else
	u_parent.right= v;
      
      if (v)
	v.parent = u_parent;
    }

  public:
    Node find(T value)
    {
      return innerFind(root, value);
    }

    Node min(T value)
    {
      if (root)
	return innerMin(root, value);
      return null;
    }

    Node max(T value)
    {
      if (root)
	return innerMax(root, value);
      return null;
    }

    void insert(T value)
    {
      Node p = null;
      Node x = root;

      while (x)
	{
	  p = x;
	  x = (less(value, x.value) ? x.left : x.right);
	}

      Node y = new Node;
      y.left = y.right = null;
      y.value = value;
      y.parent = p;

      if (p is null)
	root = y;
      else if (less(value, p.value))
	p.left = y;
      else
	p.right = y;
    }
  }
}