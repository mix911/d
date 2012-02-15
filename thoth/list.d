module mlist;

template tlist(T)
{
  class list
  {
  public:
    class node
    {
      T val;
      node next;
      node prev;
    public:
      this()
      {
      }

      this(T v)
      {
	val = v;
      }

      this(node i)
      {
	val = i.val;
	next = i.next;
	prev = i.prev;
      }

      @property void value(T v)
      {
	val = v;
      }

      @property ref T value()
      {
	return val;
      }
    }

    class iterator
    {
    private:
      node n;
    public:
      this(node nn)
      {
	n = nn;
      }

      iterator opUnary(string o) () if (o == "++")
	{
	  n = n.next;
	  return this;
	}

      @property ref T value()
      {
	return n.value;
      }

      @property void value(T value)
      {
	n.value = value;
      }

      override bool opEquals(Object o)
      {
	iterator it = cast(iterator)o;
	if (it)
	  return n is it.n;
	return false;
      }
    }

  private:
    node b;
    node e;

  public:
    this()
    {
      b = e = new node;
      b.next = null;
      e.prev = null;
    }

    void pushBack(T val)
    {
      auto tmp = new node;

      tmp.prev = e;
      tmp.next = null;

      e.value = val;
      
      e.next = tmp;
      e = tmp;
    }

    void popBack()
    {
      if (b == e) return;

      e = e.prev;
      e.next = null;
    }

    void pushFront(T val)
    {
      auto tmp = new node(val);

      tmp.prev = null;
      tmp.next = b;

      b.prev = tmp;
      b = tmp;
    }

    void popFront()
    {
      if (b == e) return;

      b = b.next;
      b.prev = null;
    }

    @property T back()
    {
      if (b == e)
	return b.value;
      return e.prev.value;
    }

    @property void back(T val)
    {
      if (b == e) 
	return;
      e.prev.value = val;
    }

    @property T front()
    {
      return b.value;
    }

    @property void front(T val)
    {
      b.value = val;
    }

    iterator begin()
    {
      return new iterator(b);
    }

    iterator end()
    {
      return new iterator(e);
    }

    iterator find(T val)
    {
      for (auto it = begin(); it != end(); ++it)
	if (it.value == val)
	  return it;
      return end();
    }

    int opApply(int delegate(ref T) dg)
    {
      int result = 0;

      for (auto it = begin(); it != end(); ++it)
	{
	  result = dg(it.value);
	  if (result)
	    break;
	}
      return result;
    }

    unittest
    {
      // tlist!int.list l;
      // l.pushBack(4);
      // assert(l.back == l.front() && l.back == 4);
      // l.popBack();
      // l.pushFront(4);
      // assert(l.back == l.front && l.back == 4);
    }
  }
}